#
# Cookbook Name:: mongodb
# Recipe:: backup
#
# Copyright 2015, Michael Belt
#

#Create directories
[
  "/var/log/mongodb-mms-backup",
  "/var/lib/mongodb-mms-backup",
  "/var/run/mongodb-mms-backup",
  "/var/lib/mongodb",
  "/etc/mongodb-mms"
].each do |d|
  directory d do
    owner node['mongodb']['user']
    group node['mongodb']['group']
    mode '755'
    recursive true
    action :create
  end
end

template '/etc/mongodb-mms/backup-agent.config' do
  source "backup-agent.config.erb"
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0755
end

template '/etc/init.d/mongodb-mms-backup-agent' do
  source "init.d-rhel-mongodb-mms-backup-agent.erb"
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0755
end

template '/etc/logrotate.d/mongodb-mms-backup-agent' do
  source "logrotate.d-rhel-mongodb-mms-backup-agent.erb"
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0755
end

ark "mongodb-mms-backup" do
  url node['mongodb']['mms']['backup']['download']
  version node['mongodb']['mms']['backup']['version']
  group node['mongodb']['group']
  owner node['mongodb']['user']
  append_env_path true
  action :install
end

service "mongodb-mms-backup-agent_new" do
  service_name "mongodb-mms-backup-agent"
  supports :status => true, :start => true, :stop => true
  action [:start, :enable]
end

