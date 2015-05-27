#
# Cookbook Name:: mongodb-tar
# Recipe:: default
#
# Copyright 2015, Michael Belt
#

include_recipe 'mongodb-tar::install'
include_recipe 'mongodb-tar::configure'
include_recipe 'mongodb-tar::scripts'

#chef_gem 'mongo'

service "mongodb_new" do
  service_name "mongodb"
  supports :status => true, :start => true, :stop => true
  action [:start, :enable]
end

include_recipe 'mongodb-tar::replicaset'

#ruby_block "Test" do
#  block do
#    require 'rubygems'
#    require 'mongo'
#    connection = Mongo::Connection.new('localhost:27017', :op_timeout => 5, :slave_ok => true)
#  end
#  action :run
#end
