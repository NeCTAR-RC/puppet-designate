#
# Unit tests for designate::zone_manager
#
require 'spec_helper'


describe 'designate::zone_manager' do
  let :params do
    {
    }
  end
  let :designate_zone_manager_params do
    {
      :workers            => '3',
      :threads            => '3000',
      :enabled_tasks      => ['domain_purge','periodic_secondary_refresh'],
      :export_synchronous => 'False',
    }
  end


  shared_examples 'designate-zone-manager' do
    context 'with default parameters' do
      it 'installs designate-zone-manager package and service' do
        is_expected.to contain_package('designate-zone-manager').with(
          :name   => 'designate-zone-manager',
          :ensure => 'present',
          :enable => 'true',
          :tag    => ['openstack','designate-package'],
        )
        is_expected.to contain_service('designate-zone-manager').with(
          :name  => 'designate-zone-manager',
          :ensure => 'running',
          :tag    => ['openstack','designate-service'],
        )
      end

      it 'configures designate zone manager with default config options' do
        [ :workers, :threads, :enabled_tasks, :export_synchronous].each {|param|
          is_expected.to contain_designate_config("service:zone_manager/#{param}").with(:value => '<SERVICE DEFAULT>')
        }
      end
    end

    context 'with non default parameters' do
      before { params.merge!( designate_zone_manager_params ) }
      it 'configures desginate zone manager with non default parameters' do
        is_expected.to contain_designate_config("service:zone_manager/workers").with(:value => '3')
        is_expected.to contain_designate_config("service:zone_manager/threads").with(:value => '3000')
        is_expected.to contain_designate_config("service:zone_manager/enabled_tasks").with(:value => ['domain_purge','periodic_secondary_refresh'])
        is_expected.to contain_designate_config("service:zone_manager/export_synchronous").with(:value => 'False')
      end
    end

  end


end
