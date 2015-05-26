#Create directories
directory '/var/log/mongodb' do
  owner 'mongodb'
  group 'mongodb'
  mode '755'
  recursive true
  action :create
end

directory '/var/run/mongodb' do
  owner 'mongodb'
  group 'mongodb'
  mode '755'
  recursive true
  action :create
end

#Setup service script
template '/etc/mongod.conf' do
  source "mongod-rpm.conf.erb"
  owner 'mongodb'
  group 'mongodb'
  mode 0755
end
