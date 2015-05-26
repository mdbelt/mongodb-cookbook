require 'tmpdir'

# Pre-req - Make sure user & group avaialbe
#create group
group 'mongodb' do
  system true
  action :create
end

#create user
user 'mongodb' do
  comment 'MongoDB User'
  gid 'mongodb'
  system true
  shell '/bin/bash'
  action :create
end

# Pre-req - Make destination directory
directory '/opt/mongodb' do
  owner 'mongodb'
  group 'mongodb'
  mode '755'
  recursive true
  action :create
end

#Tar install.  We will roughly follow instructions from:  http://docs.mongodb.org/manual/tutorial/install-mongodb-on-linux/

# 1) Download the binary files for the desired release of MongoDB.
# 2) Extract the files from the downloaded archive.
# 3) Copy the extracted archive to the target directory.
# - We will use the tar_extract LWRP from the TAR cookbook to download to temp directory cache, & extract. #1, 2, & 3 together
tar_extract 'http://downloads.10gen.com/linux/mongodb-linux-x86_64-enterprise-rhel62-3.0.3.tgz' do
  target_dir '/opt/mongodb'
  tar_flags ['--strip-components 1', '--keep-newer-files' ]
  group 'mongodb'
  user 'mongodb'
  mode '0755'
  download_dir Dir.tmpdir
  #creates version_file_check
end

# 4) Ensure the location of the binaries is in the PATH variable.
# TODO - maybe.  Can this be a service instead?

# Run MongoDB -- see same url from above, further down.
# 1)  Create the data directory.
directory '/data/db' do
  owner 'mongodb'
  group 'mongodb'
  mode '755'
  recursive true
  action :create
end
