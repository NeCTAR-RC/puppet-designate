# == Class designate::minidns
#
# Configure designate minidns service
#
# == Parameters
#
# [*package_ensure*]
#  (optional) The state of the package
#  Defaults to 'present'
#
# [*minidns_package_name*]
#  (optional) Name of the package containing minidns resources
#  Defaults to minidns_package_name from designate::params
#
# [*enabled*]
#   (optional) Whether to enable the service.
#   Defaults to true
#
# [*service_ensure*]
#  (optional) Whether the designate minidns service will be running.
#  Defaults to 'running'
#
# [*host*]
#  (optional) Addresses to bind on the host.
#  Defaults to '0.0.0.0'
#
# [*port*]
#  (optional) Service port.
#  Defaults to '5354'
#
# [*tcp_backlog*]
#  (optional) TCP backlog to use on the listening socket.
#  Defaults to '100'
#
# [*workers*]
#  (optional) Number of workers to spawn.
#  Defaults to '1'
#
class designate::minidns (
  $package_ensure       = 'present',
  $minidns_package_name = undef,
  $enabled              = true,
  $service_ensure       = 'running',
  $host                 = '0.0.0.0',
  $port                 = '5354',
  $tcp_backlog          = '100',
  $workers              = '1',
  ) inherits designate {
  include ::designate::params

  designate_config {
    'service:mdns/host'       : value => $host;
    'service:mdns/port'       : value => $port;
    'service:mdns/tcp_backlog': value => $tcp_backlog;
    'service:mdns/workers'    : value => $workers;
  }

  designate::generic_service { 'minidns':
    enabled        => $enabled,
    manage_service => $service_ensure,
    ensure_package => $package_ensure,
    package_name   => pick($minidns_package_name, $::designate::params::minidns_package_name),
    service_name   => $::designate::params::minidns_service_name,
  }
}
