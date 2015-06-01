#
# Cookbook Name:: mongodb
# Recipe:: install
#
# Copyright 2015, Michael Belt
#

# Pre-req - Make sure user & group avaialbe
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

#Tar install.  We will roughly follow instructions from:  http://docs.mongodb.org/manual/tutorial/install-mongodb-on-linux/

# 1) Download the binary files for the desired release of MongoDB.
# 2) Extract the files from the downloaded archive.
# 3) Copy the extracted archive to the target directory.
# 4) Ensure the location of the binaries is in the PATH variable.
# - We will use the ark install cookbook to download to temp directory cache, extract, add bin to path. #1, 2, 3, & 4 together
ark "mongodb" do
  url node['mongodb']['download']
  version node['mongodb']['version']
  group node['mongodb']['group']
  owner node['mongodb']['user']
  append_env_path true
  action :install
end

# Run MongoDB -- see same url from above, further down.
# 1)  Create the data directory.
directory node['mongodb']['data']['dir'] do
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode '755'
  recursive true
  action :create
end
