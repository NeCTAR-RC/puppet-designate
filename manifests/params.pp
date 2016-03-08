# Params
#
class designate::params {
  $state_path              =  '/var/lib/designate'
  # bind path
  $designatepath           = "${state_path}/bind9"
  $designatefile           = "${state_path}/bind9/zones.config"
  # Log dir
  $log_dir                 =  '/var/log/designate'
  $client_package_name     =  'python-designateclient'

  $zone_manager_service_name = 'designate-zone-manager'

  case $::osfamily {
    'RedHat': {
      # package name
      $common_package_name       = 'openstack-designate'
      $api_package_name          = 'openstack-designate-api'
      $central_package_name      = 'openstack-designate-central'
      $minidns_package_name      = 'openstack-designate-mdns'
      $agent_package_name        = 'openstack-designate-agent'
      $pool_manager_package_name = 'openstack-designate-pool-manager'
      $sink_package_name         = 'openstack-designate-sink'
      $zone_manager_package_name = 'openstack-designate-zone-manager'
      # service names
      $agent_service_name        = 'openstack-designate-agent'
      $api_service_name          = 'openstack-designate-api'
      $central_service_name      = 'openstack-designate-central'
      $minidns_service_name      = 'designate-mdns'
      $pool_manager_service_name = 'designate-pool-manager'
      $sink_service_name         = 'openstack-designate-sink'
      
    }
    'Debian': {
      # package name
      $common_package_name       = 'designate-common'
      $api_package_name          = 'designate-api'
      $central_package_name      = 'designate-central'
      $minidns_package_name      = 'designate-mdns'
      $agent_package_name        = 'designate-agent'
      $pool_manager_package_name = 'designate-pool-manager'
      $sink_package_name         = 'designate-sink'
      $zone_manager_package_name = 'designate-zone-manager'
      # service names
      $agent_service_name        = 'designate-agent'
      $api_service_name          = 'designate-api'
      $central_service_name      = 'designate-central'
      $minidns_service_name      = 'designate-mdns'
      $pool_manager_service_name = 'designate-pool-manager'
      $sink_service_name         = 'designate-sink'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }
  }
}
