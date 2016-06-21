# type for pool definitions.
# Note: Will not work for Mitaka and future versions of designate.


define designate::pool ($targets, $nameservers, $also_notifies = undef,) {

  validate_array($targets)
  validate_array($nameservers)

  designate_config {
    "pool:${name}/targets"     : value => join($targets,',');
    "pool:${name}/nameservers" : value => join($nameservers,',');
  }

  if $also_notifies {
    validate_array($also_notifies)
    designate_config { "pool:${name}/also_notifies": value  => join($also_notifies,',') }
  } else {
    designate_config { "pool:${name}/also_notifies": ensure => absent, }
  }
}
