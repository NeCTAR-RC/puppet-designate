# == Class designate::quota
#
# Configure designate quotas
#
# == Parameters
#
# [*quota_api_export_size*]
#   (optional) size of api export
#   Defaults to undef
#
# [*quota_domain_records*]
#   (optional) records per domain
#   Defaults to undef
#
# [*quota_domain_recordsets*]
#   (optional) recordsets per domain
#   Defaults to undef
#
# [*quota_domains*]
#   (optional) records per tenant
#   Defaults to undef
#
# [*quota_driver*]
#   (optional) storage driver to use
#   Defaults to undef, if undefined, 'storage' driver will be used.
#
# [*quota_recordset_records*]
#   (optional) recordsets per record
#   Defaults to undef
#

class quota(
  $quota_api_export_size   = $::os_service_default,
  $quota_domain_records    = $::os_service_default,
  $quota_domain_recordsets = $::os_service_default,
  $quota_domains           = $::os_service_default,
  $quota_driver            = $::os_service_default,
  $quota_recordset_records = $::os_service_default,
) {

  designate_config {
    'DEFAULT/quota_api_export_size':   value => $quota_api_export_size;
    'DEFAULT/quota_domain_records':    value => $quota_domain_records;
    'DEFAULT/quota_domain_recordsets': value => $quota_domain_recordsets;
    'DEFAULT/quota_domains':           value => $quota_domains;
    'DEFAULT/quota_driver':            value => $quota_driver;
    'DEFAULT/quota_recordset_records': value => $quota_recordset_records;
  }
}
