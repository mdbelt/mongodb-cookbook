default['mongodb']['version']  = '3.0.3'
default['mongodb']['download']  = "http://downloads.10gen.com/linux/mongodb-linux-x86_64-enterprise-rhel62-#{node['mongodb']['version']}.tgz"

default['mongodb']['user']  = 'mongodb'
default['mongodb']['group'] = 'mongodb'

default['mongodb']['port'] = '27017'

default['mongodb']['log']['dir']  = '/var/log/mongodb'
default['mongodb']['pid']['dir']  = '/var/run/mongodb'
default['mongodb']['data']['dir'] = '/data/db'

default['mongodb']['replicaset']['chef_search'] = ''
default['mongodb']['replicaset']['name'] = ''
