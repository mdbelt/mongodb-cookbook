#
# Cookbook Name:: mongodb
# Recipe:: scripts
#
# Copyright 2015, Michael Belt
#

#Setup service script
template '/etc/init.d/mongodb' do
  source "init.d-rpm.erb"
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0755
end
