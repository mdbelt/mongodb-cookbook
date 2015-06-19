mongodb Cookbook
====================
A cookbook to install mongodb community & enterprise.

Requirements
------------
#### cookbooks
- `iptables` - mongodb needs certain ports open.
- `ark` - install recipe uses ark installer to download & install tar.gz

#### OS
- `Red Hat / Centos` 6.x family
- ... other OS is welcome... collaborate.

Attributes
----------
#### mongodb::default
|Key|Type|Description|Default|
|:-------|:--------|:------|:------|
|`['mongodb']['version']`|String|Version|`'3.0.3'`|
|`['mongodb']['download']`|String|Download URL|....|
|`['mongodb']['user']`|String|OS User|`'mongodb'`|
|`['mongodb']['group']`|String|OS Group|`'mongodb'`|
|`['mongodb']['port']`|String|port|`'27017'`|
|`['mongodb']['log']['dir']`|String|log directory|`'/var/log/mongodb'`|
|`['mongodb']['pid']['dir']`|String|pid directory|`'/var/run/mongodb'`|
|`['mongodb']['log']['data']`|String|data directory|`'/var/lib/mongodb'`|
|`['mongodb']['replicaset']['chef_search']`|String|Chef Search Query for peers|`''`|
|`['mongodb']['replicaset']['name']`|String|Replica Set Name|`''`|
|`['mongodb']['net']['ssl']['mode']`|String|SSL Mode (disabled, allowSSL, preferSSL, requireSSL)|`nil`|
|`['mongodb']['net']['ssl']['PEMKeyFile']`|String|Location of PEM Key File|`nil`|
|`['mongodb']['net']['ssl']['CAFile']`|String|Location of CA cert File|`nil`|
|`['mongodb']['net']['ssl']['allowConnectionsWithoutCertificates']`|String|Allow a client to connect without client certificate|`nil`|
|`['mongodb']['security']['keyFile']`|String|Location plain text key file|`nil`|
|`['mongodb']['security']['clusterAuthMode']`|String|Cluster Auth Mode (keyFile, sendKeyFile, sendX509, x509)|`nil`|
|`['mongodb']['auditLog']['destination']`|String|Audit Log Destination (file, syslog, console)|`'file'`|
|`['mongodb']['auditLog']['format']`|String|Audit Log Format (BSON, JSON)|`'BSON'`|
|`['mongodb']['auditLog']['path']`|String|Audit Log File destination|`['mongodb']['log']['dir']` + `'/auditLog.bson'`|
|`['mongodb']['auditLog']['filter']`|Hash|Audit Log Filter configuration(s)|`nil`|
|`['mongodb']['setParameter']`|Hash|Additional configuration(s)|`nil`|
|`['mongodb']['mms']['automation']['version']`|String|MMS Automation Version|`2.0.8.1184-1`|
|`['mongodb']['mms']['automation']['download']`|String|MMS Automation Download URL|....|
|`['mongodb']['mms']['monitoring']['version']`|String|MMS Monitoring Version|`3.4.0.190-1`|
|`['mongodb']['mms']['monitoring']['download']`|String|MMS Monitoring Download URL|....|
|`['mongodb']['mms']['backup']['version']`|String|MMS Backup Version|`3.4.0.273-1`|
|`['mongodb']['mms']['backup']['download']`|String|MMS Backup Download URL|....|
|`['mongodb']['mms']['coordinator_agent_host']`|String|Host of client agent to allow monitoring & backup.  nil is all.|`nil`|
|`['mongodb']['mms']['mmsApiKey']`|String|MMS API Key.  If present automation recipe(s) will run.|`''`|
|`['mongodb']['mms']['mmsGroupId']`|String|MMS Group ID.|`''`|

Usage
-----
#### mongodb::default
Just include `mongodb` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mongodb]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Michael Belt (mdbelt)
