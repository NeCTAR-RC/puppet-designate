class designate::api inherits designate {

  package {'designate-api':
    ensure=> installed,
  }
  
  service {'designate-api':
    ensure    => running,
    provider  => upstart,
    subscribe => [ File['designate-config'],
                   File['designate-apipaste'],],
  }

 firewall {'100 designate':
    dport  => 9001,
    proto  => 'tcp',
    action => 'accept',
  }

  nagios::service {'http_designate-api':
    check_command => 'http_port!9001',
    servicegroups => 'openstack-endpoints';
  }
  
  nagios::nrpe::service {
    'service_designate_api':
      check_command => "/usr/lib/nagios/plugins/check_procs -c 1:1 -u designate -a /usr/bin/designate-api";
  }

}
