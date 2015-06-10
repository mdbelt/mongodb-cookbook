#
# Cookbook Name:: mongodb
# Recipe:: automation
#
# Copyright 2015, Michael Belt
#

remote_file "/tmp/mongodb-mms-automation-agent-manager-latest.x86_64.rpm" do
  source "https://mms.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-manager-latest.x86_64.rpm"
end

package "mongodb-mms-automation-agent" do
  source "/tmp/mongodb-mms-automation-agent-manager-latest.x86_64.rpm"
  action :install
end

template '/etc/mongodb-mms/automation-agent.config' do
  source "automation-agent.config.erb"
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode 0755
end

directory "/var/log/mongodb-mms-automation" do
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode '755'
  recursive true
  action :create
end

directory "/var/lib/mongodb-mms-automation" do
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode '755'
  recursive true
  action :create
end

directory "/var/lib/mongodb" do
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode '755'
  recursive true
  action :create
end

directory "/var/run/mongodb-mms-automation" do
  owner node['mongodb']['user']
  group node['mongodb']['group']
  mode '755'
  recursive true
  action :create
end

service "mongodb-mms-automation-agent_new" do
  service_name "mongodb-mms-automation-agent"
  supports :status => true, :start => true, :stop => true
  action [:start, :enable]
end

