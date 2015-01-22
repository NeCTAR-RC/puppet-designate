# Openstack designate
class designate(
  $keystone_user='designate',
  $keystone_pass,
  $database_connection,
  $powerdns_db_connection,
  $rabbit_hosts,
  $rabbit_user='designate',
  $rabbit_pass,
  $rabbit_virtual_host,
  $memcached_servers='localhost:11211',
  $managed_resource_email)
{

  $openstack_version = hiera('openstack_version')
  $keystone_host = hiera('keystone::host')
  $keystone_protocol = hiera('keystone::protocol')
  $keystone_service_tenant = hiera('keystone::service_tenant')

  include mysql::python

  package {'designate-common':
    ensure => installed,
  }

  file { 'designate-config':
    ensure  => present,
    path    => '/etc/designate/designate.conf',
    owner   => designate,
    group   => designate,
    mode    => '0600',
    content => template("designate/${openstack_version}/designate.conf.erb"),
    require => Package['designate-common'],
  }

  file { 'designate-apipaste':
    ensure  => present,
    path    => '/etc/designate/api-paste.ini',
    owner   => designate,
    group   => designate,
    mode    => '0600',
    content => template("designate/${openstack_version}/api-paste.ini.erb"),
    require => Package['designate-common'],
  }

  file { 'designate-policy':
    ensure  => present,
    path    => '/etc/designate/policy.json',
    owner   => designate,
    group   => designate,
    mode    => '0600',
    source  => "puppet:///modules/designate/${openstack_version}/policy.json",
    require => Package['designate-common'],
  }
}
