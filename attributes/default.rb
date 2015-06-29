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
default['mongodb']['net']['ssl']['allowConnectionsWithoutCertificates'] = nil

default['mongodb']['security']['keyFile'] = nil
default['mongodb']['security']['clusterAuthMode'] = nil

default['mongodb']['auditLog']['destination'] = 'file'
default['mongodb']['auditLog']['format'] = 'BSON'
default['mongodb']['auditLog']['path'] = "#{node['mongodb']['log']['dir']}/auditLog.bson"
default['mongodb']['auditLog']['filter'] = nil

default['mongodb']['setParameter']['auditAuthorizationSuccess'] = nil
default['mongodb']['setParameter']['saslauthdPath'] = nil
default['mongodb']['setParameter']['authenticationMechanisms'] = nil

default['mongodb']['mms']['automation']['version']  = '2.0.8.1184-1'
default['mongodb']['mms']['automation']['download'] = "https://mms.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-#{node['mongodb']['mms']['automation']['version']}.linux_x86_64.tar.gz"

default['mongodb']['mms']['monitoring']['version']  = '3.4.0.190-1'
default['mongodb']['mms']['monitoring']['download'] = "https://mms.mongodb.com/download/agent/monitoring/mongodb-mms-monitoring-agent-#{node['mongodb']['mms']['monitoring']['version']}.linux_x86_64.tar.gz"

default['mongodb']['mms']['backup']['version']  = '3.4.0.273-1'
default['mongodb']['mms']['backup']['download'] = "https://mms.mongodb.com/download/agent/backup/mongodb-mms-backup-agent-#{node['mongodb']['mms']['backup']['version']}.linux_x86_64.tar.gz"

default['mongodb']['mms']['coordinator_agent_host'] = nil

default['mongodb']['mms']['mmsApiKey']  = ''
default['mongodb']['mms']['mmsGroupId'] = ''
