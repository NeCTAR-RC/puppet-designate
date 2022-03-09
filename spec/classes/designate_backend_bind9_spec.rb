#
# Unit tests for designate::backend::bind9
#
require 'spec_helper'

describe 'designate::backend::bind9' do

  shared_examples 'designate-backend-bind9' do
    context 'with default params' do
      # TODO(tkajinam): remove this once we update the default value
      let :params do
        { :manage_pool => true }
      end
      it 'configures named and pool' do
        is_expected.to contain_concat_fragment('dns allow-new-zones').with(
          :target => platform_params[:dns_optionspath],
          :content => 'allow-new-zones yes;'
        )
        is_expected.to contain_file('/etc/designate/pools.yaml').with(
          :ensure => 'present',
          :path   => '/etc/designate/pools.yaml',
          :owner  => 'designate',
          :group  => 'designate',
          :mode   => '0640',
        )
        is_expected.to contain_exec('designate-manage pool update').with(
          :command     => 'designate-manage pool update',
          :path        => '/usr/bin',
          :user        => 'designate',
          :refreshonly => true,
        )
      end
    end

    context 'with named configuration disabled' do
      let :params do
        { :configure_bind => false }
      end
      it 'does not configure named' do
        is_expected.not_to contain_concat_fragment('dns allow-new-zones')
      end
    end

    context 'with pool management disabled' do
      let :params do
        { :manage_pool => false }
      end
      it 'does not configure pool' do
        is_expected.to_not contain_file('/etc/designate/pools.yaml')
        is_expected.to_not contain_exec('designate-manage pool update')
      end
    end

  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts({
          :concat_basedir => '/var/lib/puppet/concat',
        }))
      end

      let(:platform_params) do
        case facts[:osfamily]
        when 'Debian'
          {
            :dns_optionspath => '/etc/bind/named.conf.options'
          }
        when 'RedHat'
          {
            :dns_optionspath => '/etc/named/options.conf'
          }
        end
      end
      it_behaves_like 'designate-backend-bind9'
    end
  end

end
