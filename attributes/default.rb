default['mongodb']['version']  = '3.0.3'
default['mongodb']['download'] = "http://downloads.10gen.com/linux/mongodb-linux-x86_64-enterprise-rhel62-#{node['mongodb']['version']}.tgz"

default['mongodb']['user']  = 'mongodb'
default['mongodb']['group'] = 'mongodb'

default['mongodb']['port'] = '27017'

default['mongodb']['log']['dir']  = '/var/log/mongodb'
default['mongodb']['pid']['dir']  = '/var/run/mongodb'
default['mongodb']['data']['dir'] = '/var/lib/mongodb'

default['mongodb']['replicaset']['chef_search'] = ''
default['mongodb']['replicaset']['name'] = ''

default['mongodb']['net']['ssl']['mode'] = nil
default['mongodb']['net']['ssl']['PEMKeyFile'] = nil
default['mongodb']['net']['ssl']['CAFile'] = nil

default['mongodb']['security']['keyFile'] = nil
default['mongodb']['security']['clusterAuthMode'] = nil

default['mongodb']['auditLog']['destination'] = 'file'
default['mongodb']['auditLog']['format'] = 'BSON'
default['mongodb']['auditLog']['path'] = "#{node['mongodb']['log']['dir']}/auditLog.bson"
default['mongodb']['auditLog']['filter'] = nil

default['mongodb']['setParameter'] = nil

default['mongodb']['mms_agent']['mmsApiKey']  = ''
default['mongodb']['mms_agent']['mmsGroupId'] = ''
