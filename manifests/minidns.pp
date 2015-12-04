# designate minidns
class designate::minidns (
  $workers     = '1',
  $host        = '0.0.0.0',
  $port        = '5354',
  $tcp_backlog = '100',
  ) inherits profile::core::designate {

  package {'designate-mdns': ensure => 'installed', }
  service {'designate-mdns': ensure => 'running', }

  designate_config {
    'service:mdns/workers'      : value => $workers;
    'service:mdns/host'         : value => $host;
    'service:mdns/port'         : value => $port;
    'service:mdns/tcp_backlog'  : value => $tcp_backlog;
  }
}
