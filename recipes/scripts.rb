#Setup service script
template '/etc/init.d/mongodb' do
  source "init.d-rpm.erb"
  owner 'mongodb'
  group 'mongodb'
  mode 0755
end
