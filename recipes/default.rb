#
# Cookbook Name:: mongodb
# Recipe:: default
#
# Copyright 2015, Michael Belt
#

include_recipe 'mongodb::install'
include_recipe 'mongodb::configure'
include_recipe 'mongodb::scripts'

service "mongodb_new" do
  service_name "mongodb"
  supports :status => true, :start => true, :stop => true
  action [:start, :enable]
end

if !node['mongodb']['replicaset']['name'].empty?
  include_recipe 'mongodb::replicaset'
end
