define designate::pool ( $id, $targets, $nameservers) {

  designate_config {
    "pool:${id}/targets"     : value => $targets;
    "pool:${id}/nameservers" : value => $nameservers;
  }
}
