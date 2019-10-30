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
  notifies :restart, 'service[mongodb]', :delayed
end

#Fix RHEL ulimit warning.  See:  http://docs.mongodb.org/manual/reference/ulimit/
cookbook_file "99-mongodb-nproc.conf" do
  path "/etc/security/limits.d/99-mongodb-nproc.conf"
end

file 'keyfile' do
  path node['mongodb']['security']['keyFile']['file']
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0600
  content node['mongodb']['security']['keyFile']['content']
  not_if { node['mongodb']['security']['keyFile']['content'].nil? }
end

#Open up port
include_recipe 'iptables'
iptables_rule 'mongodb-port' do
  action :enable
end

#Clamp down swap
#node.default['sysctl']['params']['vm']['swappiness'] = 10
#include_recipe 'sysctl::apply'
sysctl_param 'vm.swappiness' do
  value 1
  ignore_error true
end


