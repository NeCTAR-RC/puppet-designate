# == Type designate::pool_nameserver
#
# Type for individual nameservers within a pool.
#
define designate::pool_nameserver ( $id, $host, $port, ) {

  designate_config {
    "pool_nameserver:${id}/host"     : value => $host;
    "pool_nameserver:${id}/port"     : value => $port;
  }
}
