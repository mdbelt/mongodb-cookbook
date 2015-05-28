Chef::Log.warn("**********************Begin Repl Dev Block")

ruby_block "Does_Current_Need_Repl_Work" do
  block do
    cmd = Mixlib::ShellOut.new("/opt/mongodb/bin/mongo #{node['ipaddress']}:27017 --quiet --eval 'rs.status()[\"code\"]'")
    status = cmd.run_command.stdout.strip
    if status.eql?("94")
      notifies :run, resources(:ruby_block => "Initiate_Current_Node"), :immediately
    end
  end
end

ruby_block "Initiate_Current_Node" do
  block do
    Mixlib::ShellOut.new("/opt/mongodb/bin/mongo #{node['ipaddress']}:27017 --quiet --eval 'printjsononeline(rs.initiate())'").run_command
  end
  action :nothing
end

#rs.status().members.forEach(function(z){if(z.stateStr == "PRIMARY")printjson(z.name);})

Chef::Log.warn("**********************End Repl Dev Block")
