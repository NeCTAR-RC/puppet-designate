class designate::develop(
  $git_url='https://github.com/NeCTAR-RC/designate.git',
  $branch='nectar/juno',
) inherits designate {

  include designate::develop::api
  include designate::develop::central

  Package['designate-common'] {
      ensure => absent,
  }

  exec {"virtualenv /opt/${openstack_version}":
    path    => '/usr/bin',
    creates => "/opt/${openstack_version}/bin/activate",
  }

  git::clone { 'designate':
    git_repo        => $git_url,
    projectroot     => '/opt/designate',
    cloneddir_user  => 'designate',
    cloneddir_group => 'designate',
    branch          => $branch,
  }

  exec {"pip install -e .":
    cwd     => '/opt/designate/',
    path    => "/opt/${openstack_version}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    creates => '/opt/juno/bin/designate-manage',
    timeout => 3600,
    require => Git::Clone['designate'],
  }

  exec {"pip install mysql-python":
    cwd     => '/opt/designate/',
    path    => "/opt/${openstack_version}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    creates => "/opt/${openstack_version}/lib/python2.7/site-packages/MySQLdb",
    timeout => 3600,
    require => Git::Clone['designate'],
  }
  exec {"pip install python-memcached":
    cwd     => '/opt/designate/',
    path    => "/opt/${openstack_version}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    creates => "/opt/${openstack_version}/lib/python2.7/site-packages/memcache.py",
    timeout => 3600,
    require => Git::Clone['designate'],
  }

  file {['/etc/designate', '/var/log/designate', '/var/lib/designate']:
    ensure => directory,
    owner  => designate,
    group  => designate,
  }

  user {'designate':
    home => '/var/lib/designate',
  }

  file { '/etc/sudoers.d/designate_sudoers':
    content => "Defaults:designate !requiretty\n\ndesignate ALL = (root) NOPASSWD: /usr/local/bin/designate-rootwrap\n",
    mode    => '0640',
  }
  file { '/etc/designate/rootwrap.conf':
    target => '/opt/designate/etc/designate/rootwrap.conf.sample',
    ensure => link,
  }

  file { '/etc/designate/rootwrap.d':
    target => '/opt/designate/etc/designate/rootwrap.d',
    ensure => link,
  }

  file {'/usr/local/bin/designate-manage':
    ensure => link,
    target => "/opt/${openstack_version}/bin/designate-manage",
  }
  file {'/usr/local/bin/designate-rootwrap':
    ensure => link,
    target => "/opt/${openstack_version}/bin/designate-rootwrap",
  }

}

class designate::develop::api inherits designate::api {
  Package['designate-api'] {
    ensure=> absent,
  }

  file {'/etc/init/designate-api.conf':
    source => 'puppet:///modules/designate/develop/api-init.conf',
    before => Service['designate-api'],
  }
  file {'/usr/local/bin/designate-api':
    ensure => link,
    target => "/opt/${openstack_version}/bin/designate-api",
  }

}

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
    target => "/opt/${openstack_version}/bin/designate-central",
  }
}
