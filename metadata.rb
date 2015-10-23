name             'mongodb'
maintainer       'Michael Belt'
maintainer_email 'michael@mdbelt.com'
license          'Apache 2.0'
description      'Installs/Configures mongodb-tar'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

#TODO -> Fill out supports block

depends 'ark'
depends 'iptables'
depends 'sysctl'
depends 'munin'
