# == Type designate::pool_target
#
# Configure designate pool manager service
#
# == Parameters
#
# [*masters*]
#  Minidns server(s) the target is going to accept updates from,
#  in format ip:port
#
# [*type*]
#  Eg bind9, powerdns
#
# [*options*]
#  These will vary depending on the target type, for example
#  'port: 53, host: 123.456.78.9, connection: mysql://user:pass@127.0.0.1/database'
define designate::pool_target ( $id, $masters, $type, $options, ) {

  designate_config {
    "pool_target:${id}/masters"  : value => $masters;
    "pool_target:${id}/type"     : value => $type;
    "pool_target:${id}/options"  : value => $options;
  }
}
