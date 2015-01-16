# Development class for designate central
class designate::develop::central inherits designate::central {
  Package['designate-central'] {
    ensure=> absent,
  }

  file {'/etc/init/designate-central.conf':
    source => 'puppet:///modules/designate/develop/central-init.conf',
    before => Service['designate-central'],
  }
  file {'/usr/local/bin/designate-central':
    ensure => link,
    target => "/opt/${designate::openstack_version}/bin/designate-central",
  }
}
