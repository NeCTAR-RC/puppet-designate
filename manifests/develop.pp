# Sets up designate for development using git checkouts

class designate::develop(
  $git_url='https://github.com/NeCTAR-RC/designate.git',
  $branch='nectar/juno',
) inherits designate {

  include designate::develop::api
  include designate::develop::central

  Package['designate-common'] {
      ensure => absent,
  }

  exec {'designate-virtualenv':
    command => "virtualenv /opt/${designate::openstack_version}",
    path    => '/usr/bin',
    creates => "/opt/${designate::openstack_version}/bin/activate",
  }

  git::clone { 'designate':
    git_repo        => $git_url,
    projectroot     => '/opt/designate',
    cloneddir_user  => 'designate',
    cloneddir_group => 'designate',
    branch          => $branch,
  }

  exec {'designate-pip-install':
    command => 'pip install -e .',
    cwd     => '/opt/designate/',
    path    => "/opt/${designate::openstack_version}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    creates => '/opt/juno/bin/designate-manage',
    timeout => 3600,
    require => Git::Clone['designate'],
  }

  exec {'designate-pip-install-mysql-python':
    command => 'pip install mysql-python',
    cwd     => '/opt/designate/',
    path    => "/opt/${designate::openstack_version}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    creates => "/opt/${designate::openstack_version}/lib/python2.7/site-packages/MySQLdb",
    timeout => 3600,
    require => Git::Clone['designate'],
  }

  exec {'designate-pip-install-python-memcached':
    command => 'pip install python-memcached',
    cwd     => '/opt/designate/',
    path    => "/opt/${designate::openstack_version}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    creates => "/opt/${designate::openstack_version}/lib/python2.7/site-packages/memcache.py",
    timeout => 3600,
    require => Git::Clone['designate'],
  }

  file {['/etc/designate', '/var/log/designate', '/var/lib/designate']:
    ensure => directory,
    owner  => designate,
    group  => designate,
    mode   => '0755',
  }

  user {'designate':
    home => '/var/lib/designate',
  }

  file { '/etc/sudoers.d/designate_sudoers':
    content => "Defaults:designate !requiretty\n\ndesignate ALL = (root) NOPASSWD: /usr/local/bin/designate-rootwrap\n",
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
  }
  file { '/etc/designate/rootwrap.conf':
    ensure => link,
    target => '/opt/designate/etc/designate/rootwrap.conf.sample',
  }

  file { '/etc/designate/rootwrap.d':
    ensure => link,
    target => '/opt/designate/etc/designate/rootwrap.d',
  }

  file {'/usr/local/bin/designate-manage':
    ensure => link,
    target => "/opt/${designate::openstack_version}/bin/designate-manage",
  }
  file {'/usr/local/bin/designate-rootwrap':
    ensure => link,
    target => "/opt/${designate::openstack_version}/bin/designate-rootwrap",
  }

}
