# Development class for designate API
class designate::develop::api inherits designate::api {
  Package['designate-api'] {
    ensure=> absent,
  }

  file {'/etc/init/designate-api.conf':
    source => 'puppet:///modules/designate/develop/api-init.conf',
    before => Service['designate-api'],
    owner  => 'designate',
    group  => 'designate',
    mode   => '0600'
  }
  file {'/usr/local/bin/designate-api':
    ensure => link,
    target => "/opt/${designate::openstack_version}/bin/designate-api",
  }

}
