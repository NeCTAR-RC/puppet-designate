# designate pool manager
class designate::poolmanager (
  $default_pool_id = undef,
  $pool_name = 'default',
  $threshold_percentage = '100',
  $poll_timeout = '30',
  $poll_retry_interval = '2',
  $poll_max_retries = '3',
  $periodic_sync_interval = '120',
  $default_nameserver_id = undef,
  $default_target_id = undef,
  $default_nameserver_host = undef,
  $default_nameserver_port = '53',
  $default_target_masters = undef,
  $default_target_type = 'powerdns',
  $default_target_port = '53',
  $default_target_host = undef,
  $default_target_connection = undef,

) inherits profile::core::designate {
  package {'designate-pool-manager':
    ensure => installed,
  }
  service {'designate-pool-manager':
    ensure => running,
  }

# https://specs.openstack.org/openstack/designate-specs/specs/kilo/server-pools-service.html
# these settings will, presumably, be added to puppet-designate
# liberty release.
  designate_config {
    'service:pool_manager/pool_id':                     value => $default_pool_id;
    'service:pool_manager/pool_name':                   value => $pool_name;
    'service:pool_manager/threshold_percentage':        value => $threshold_percentage;
    'service:pool_manager/poll_timeout':                value => $poll_timeout;
    'service:pool_manager/poll_retry_interval':         value => $poll_retry_interval;
    'service:pool_manager/poll_max_retries':            value => $poll_max_retries;
    'service:pool_manager/periodic_sync_interval':      value => $periodic_sync_interval;
    "pool:${default_pool_id}/nameservers":              value => $default_nameserver_id;
    "pool:${default_pool_id}/targets":                  value => $default_target_id;
    "pool_nameserver:${default_nameserver_id}/host":    value => $default_nameserver_host;
    "pool_nameserver:${default_nameserver_id}/port":    value => $default_nameserver_port;
  #pool_target: hosts the target is going to accept updates from,
  # ie the ip addr of the minidns server(s)
    "pool_target:${default_target_id}/masters":         value => $default_target_masters;
    "pool_target:${default_target_id}/type":            value => $default_target_type;
#eg port: 53, host: 115.146.84.149, connection: mysql://powerdns_l:test@127.0.0.1/powerdns_l
    "pool_target:${default_target_id}/options":         value =>
          "port: ${default_target_port}, host: ${default_target_host}, connection: ${default_target_connection}";
  }

}
