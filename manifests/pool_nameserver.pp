# == Type designate::pool_nameserver
#
# Type for individual nameservers within a pool.
#
define designate::pool_nameserver ($host, $port, ) {

  designate_config {
    "pool_nameserver:${name}/host"     : value => $host;
    "pool_nameserver:${name}/port"     : value => $port;
  }
}
