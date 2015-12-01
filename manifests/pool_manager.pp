# == Class designate::pool_manager
#
# Configure designate pool manager service
#
# == Parameters
#
# [*package_ensure*]
#  (optional) The state of the package
#  Defaults to 'present'
#
# [*pool_manager_package_name*]
#  (optional) Name of the package containing central resources
#  Defaults to central_package_name from designate::params
#
# [*enabled*]
#   (optional) Whether to enable services.
#   Defaults to true
#
# [*service_ensure*]
#  (optional) Whether the designate central service will be running.
#  Defaults to 'running'
#
# [*pool_id*]
#  The ID of the pool managed by this instance of the Pool Manager.
#
# [*threshold_percentage*]
#  (optional) The percentage of servers requiring a successful update for a
#  domain change to be considered active.
#  Defaults to 100.
#
# [*poll_timeout*]
#  (optional) The time to wait for a response from a server.
#  Defaults to 30.
#
# [*poll_retry_interval*]
#  (The time between retrying to send a request and waiting for a response from
#  a server.
#  Defaults to 30.
#
# [*poll_max_retries*]
#  (optional) The maximum number of times to retry sending a request and wait
#  for a response from a server.
#  Defaults to 10
#
# [*periodic_sync_interval*]
#  (optional) The time between synchronizing the servers with storage.
#  Defaults to 1800.
#
# [*pool_hash*]
# (optional) config hash of pool(s) to be configured.
#
# [*pool_target_hash*]
# (optional) config hash of pool target(s) to be configured.
#
# [*pool_nameserver_hash*]
# (optional) config hash of pool nameserver(s) to be configured.

class designate::pool_manager (
  $package_ensure            = 'present',
  $pool_manager_package_name = undef,
  $enabled                   = true,
  $service_ensure            = 'running',
  $pool_id,
  $threshold_percentage      = '100',
  $poll_timeout              = '30',
  $poll_retry_interval       = '2',
  $poll_max_retries          = '10',
  $periodic_sync_interval    = '1800',
  $pool_hash                 = {},
  $pool_nameserver_hash      = {},
  $pool_target_hash          = {},

) inherits designate {
  include ::designate::params

  designate::generic_service { 'pool_manager':
    enabled        => $enabled,
    manage_service => $service_ensure,
    ensure_package => $package_ensure,
    package_name   => pick($pool_manager_package_name, $::designate::params::pool_manager_package_name),
    service_name   => $::designate::params::pool_manager_service_name,
  }

  designate_config {
    'service:pool_manager/pool_id'                : value => $pool_id;
    'service:pool_manager/threshold_percentage'   : value => $threshold_percentage;
    'service:pool_manager/poll_timeout'           : value => $poll_timeout;
    'service:pool_manager/poll_retry_interval'    : value => $poll_retry_interval;
    'service:pool_manager/poll_max_retries'       : value => $poll_max_retries;
    'service:pool_manager/periodic_sync_interval' : value => $periodic_sync_interval;
  }

  create_resources("pool", hiera_hash('designate::pool_manager::pool_hash'))
  create_resources("pool_nameserver", hiera_hash('designate::pool_manager::pool_nameserver_hash'))
  create_resources("pool_target", hiera_hash('designate::pool_manager::pool_target_hash'))
}
