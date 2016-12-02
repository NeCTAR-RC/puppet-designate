#
# Unit tests for designate::quota
#
require 'spec_helper'

describe 'designate::quota' do

  shared_examples 'designate-quota' do

    context 'with default parameters' do

      it 'configures designate-quota with default parameters' do
        is_expected.to contain_designate_config('DEFAULT/quota_api_export_size').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_designate_config('DEFAULT/quota_domain_records').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_designate_config('DEFAULT/quota_domain_recordsets').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_designate_config('DEFAULT/quota_domains').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_designate_config('DEFAULT/quota_driver').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_designate_config('DEFAULT/quota_recordset_records').with_value('<SERVICE DEFAULT>')
      end

      context 'when using custom options' do
        before { params.merge!(:quota_api_export_size => '20',
                               :quota_domain_records => '20',
                               :quota_domain_recordsets => '20',
                               :quota_domains => '20'
                               :quota_driver => 'dummy'
                               :quota_recordset_records => '20'
                              )}
        it 'configures designate-quota with custom options ' do
          is_expected.to contain_designate_config('DEFAULT/quota_api_export_size').with_value('20')
          is_expected.to contain_designate_config('DEFAULT/quota_domain_records').with_value('20')
          is_expected.to contain_designate_config('DEFAULT/quota_domain_recordsets').with_value('20')
          is_expected.to contain_designate_config('DEFAULT/quota_domains').with_value('20')
          is_expected.to contain_designate_config('DEFAULT/quota_driver').with_value('dummy')
          is_expected.to contain_designate_config('DEFAULT/quota_recordset_records').with_value('20')
        end
      end
    end
  end

end
