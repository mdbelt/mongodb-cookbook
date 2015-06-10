#
# Cookbook Name:: mongodb
# Recipe:: install
#
# Copyright 2015, Michael Belt
#

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
