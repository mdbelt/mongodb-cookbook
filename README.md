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
|:-------|:--------|:------|------:|
|`['mongodb']['version']`|String|Version|3.0.3|
|`['mongodb']['download']`|String|Download URL|....|
|`['mongodb']['user']`|String|OS User|mongodb|
|`['mongodb']['group']`|String|OS Group|mongodb|
|`['mongodb']['port']`|String|port|mongodb|
|`['mongodb']['log']['dir']`|String|log directory|/var/log/mongodb|
|`['mongodb']['pid']['dir']`|String|pid directory|/var/run/mongodb|
|`['mongodb']['log']['data']`|String|data directory|/var/lib/mongodb|
|`['mongodb']['replicaset']['chef_search']`|String|Chef Search Query for peers|''|
|`['mongodb']['replicaset']['name']`|String|Replica Set Name|''|

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
