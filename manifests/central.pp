class designate::central inherits designate {

  package {'designate-central':
    ensure=> installed,
  }
  
  service {'designate-central':
    ensure    => running,
    provider  => upstart,
    require   => Package['designate-central'],
    subscribe => File['designate-config'],
  }
  
  nagios::nrpe::service {
    'service_designate_central':
      check_command => "/usr/lib/nagios/plugins/check_procs -c 1:1 -u designate -a /usr/bin/designate-central";
  }

}
