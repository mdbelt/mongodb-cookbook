#
# Cookbook Name:: mongodb-tar
# Recipe:: default
#
# Copyright 2015, Michael Belt
#

include_recipe 'mongodb-tar::install'
include_recipe 'mongodb-tar::configure'
include_recipe 'mongodb-tar::scripts'

service "mongodb_new" do
  service_name "mongodb"
  supports :status => true, :start => true, :stop => true
  action [:start, :enable]
end
