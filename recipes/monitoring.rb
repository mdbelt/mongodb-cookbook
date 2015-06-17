#
# Cookbook Name:: mongodb
# Recipe:: monitoring
#
# Copyright 2015, Michael Belt
#

#Create directories
[
  "/var/log/mongodb-mms-monitoring",
  "/var/lib/mongodb-mms-monitoring",
  "/var/run/mongodb-mms-monitoring",
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

template '/etc/mongodb-mms/monitoring-agent.config' do
  source "monitoring-agent.config.erb"
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0755
end

template '/etc/init.d/mongodb-mms-monitoring-agent' do
  source "init.d-rhel-mongodb-mms-monitoring-agent.erb"
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0755
end

template '/etc/logrotate.d/mongodb-mms-monitoring-agent' do
  source "logrotate.d-rhel-mongodb-mms-monitoring-agent.erb"
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0755
end

ark "mongodb-mms-monitoring" do
  url node['mongodb']['mms']['monitoring']['download']
  version node['mongodb']['mms']['monitoring']['version']
  group node['mongodb']['group']
  owner node['mongodb']['user']
  append_env_path true
  action :install
end

service "mongodb-mms-monitoring-agent_new" do
  service_name "mongodb-mms-monitoring-agent"
  supports :status => true, :start => true, :stop => true
  action [:start, :enable]
end

