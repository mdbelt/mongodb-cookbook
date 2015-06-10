#
# Cookbook Name:: mongodb
# Recipe:: structure
#
# Copyright 2015, Michael Belt
#

#create group
group node['mongodb']['group'] do
  system true
  action :create
end

#create user
user node['mongodb']['user'] do
  comment 'MongoDB User'
  gid node['mongodb']['group']
  system true
  shell '/bin/bash'
  action :create
end

#Create directories
[
  node['mongodb']['log']['dir'],
  node['mongodb']['pid']['dir'],
  node['mongodb']['data']['dir']
].each do |d|
  directory d do
    owner node['mongodb']['user']
    group node['mongodb']['group']
    mode '755'
    recursive true
    action :create
  end
end
