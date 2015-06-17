#
# Cookbook Name:: mongodb
# Recipe:: automation
#
# Copyright 2015, Michael Belt
#

#Create directories
[
  "/var/log/mongodb-mms-automation",
  "/var/lib/mongodb-mms-automation",
  "/var/run/mongodb-mms-automation",
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

template '/etc/mongodb-mms/automation-agent.config' do
  source "automation-agent.config.erb"
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0755
end

template '/etc/init.d/mongodb-mms-automation-agent' do
  source "init.d-rhel-mongodb-mms-automation-agent.erb"
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0755
end

ark "mongodb-mms-automation" do
  url node['mongodb']['mms']['automation']['download']
  version node['mongodb']['mms']['automation']['version']
  group node['mongodb']['group']
  owner node['mongodb']['user']
  append_env_path true
  action :install
end

service "mongodb-mms-automation-agent_new" do
  service_name "mongodb-mms-automation-agent"
  supports :status => true, :start => true, :stop => true
  action [:start, :enable]
end

