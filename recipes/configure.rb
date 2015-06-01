#
# Cookbook Name:: mongodb
# Recipe:: configure
#
# Copyright 2015, Michael Belt
#

#Setup mongo configuration file
template '/etc/mongod.conf' do
  source "mongod-rpm.conf.erb"
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0755
end

#Open up port
include_recipe 'iptables'
iptables_rule 'mongodb-port' do
  action :enable
end
