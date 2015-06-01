#
# Cookbook Name:: mongodb
# Recipe:: configure
#
# Copyright 2015, Michael Belt
#

#Create directories
directory node['mongodb']['log']['dir'] do
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode '755'
  recursive true
  action :create
end

directory node['mongodb']['pid']['dir'] do
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode '755'
  recursive true
  action :create
end

#Setup service script
template '/etc/mongod.conf' do
  source "mongod-rpm.conf.erb"
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0755
end

#Open up port
#TODO - attribute the port number.
include_recipe 'iptables'
iptables_rule 'mongodb-port' do
  action :enable
end
