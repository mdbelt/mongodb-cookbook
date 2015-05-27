Chef::Log.warn("**********************Begin Repl Dev Block")


execute "/opt/mongodb/bin/mongo #{node['ipaddress']}:27017 -eval 'printjson(rs.initiate())'" do
  only_if do
    #Only Initiate if rs.status() returns error code 94.
    cmd = Mixlib::ShellOut.new("/opt/mongodb/bin/mongo #{node['ipaddress']}:27017 -eval 'rs.status()[\"code\"]'")
    status = cmd.run_command.stdout.strip
    status.end_with?("94")
  end
end

Chef::Log.warn("**********************End Repl Dev Block")
