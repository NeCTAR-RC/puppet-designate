define designate::pool ($targets, $nameservers) {

  designate_config {
    "pool:${name}/targets"     : value => $targets;
    "pool:${name}/nameservers" : value => $nameservers;
  }
}
