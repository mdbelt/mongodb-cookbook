#Chef::Log.warn("**********************Begin Repl Dev Block")

ruby_block "Does_Current_Need_Repl_Work" do
  block do
#Search for error 94.  Non initiated (or not added) to RS
    cmd = Mixlib::ShellOut.new("/opt/mongodb/bin/mongo #{node['ipaddress']}:27017 --quiet --eval 'rs.status()[\"code\"]'")
    status = cmd.run_command.stdout.strip
    if status.eql?("94")
      notifies :run, resources(:ruby_block => "Search_For_Primary"), :immediately
    end
  end
end

ruby_block "Initiate_Current_Node" do
  block do
#Initiate the RS on current node
    Mixlib::ShellOut.new("/opt/mongodb/bin/mongo #{node['ipaddress']}:27017 --quiet --eval 'printjsononeline(rs.initiate())'").run_command
  end
  action :nothing
end

ruby_block "Search_For_Primary" do
  block do
#Search for existing primary node.  Use Search criteria.
#TODO attribute the criteria & port to look on
    node.run_state['Primary_Mongo'] = ""
    Chef::Search::Query.new.search(:node, "role:direct-mongo-tar")[0].each do |n|
#      Chef::Log.warn("**** Input: /opt/mongodb/bin/mongo #{n['hostname']}:27017 --quiet --eval 'rs.status().members.forEach(function(z){if(z.stateStr == \"PRIMARY\")print(z.name);})'")
      node.run_state['Primary_Mongo'] = Mixlib::ShellOut.new("/opt/mongodb/bin/mongo #{n['hostname']}:27017 --quiet --eval 'rs.status().members.forEach(function(z){if(z.stateStr == \"PRIMARY\")print(z.name);})'").run_command.stdout.strip
#      Chef::Log.warn("**** Output: " + node.run_state['Primary_Mongo'])
#If results in error clear out, no match.
      if node.run_state['Primary_Mongo'].upcase.include? "ERROR"
#Chef::Log.warn("**** error detected")
        node.run_state['Primary_Mongo'] = ""
      end
#If contains data then break, we've found the Primary node.
      if !node.run_state['Primary_Mongo'].empty?
#Chef::Log.warn("**** located: " + node.run_state['Primary_Mongo'])
        break
      end
    end
    if node.run_state['Primary_Mongo'].empty?
#If there is no Primary discovered, initiate the current node.
      notifies :run, resources(:ruby_block => "Initiate_Current_Node"), :immediately
    else
#If there is a Primary located then add current to RS.
      notifies :run, resources(:ruby_block => "Add_Current_To_Existing"), :immediately
    end
  end
  action :nothing
end

ruby_block "Add_Current_To_Existing" do
  block do
#Add the current node to the RS
#Chef::Log.warn("****** input: /opt/mongodb/bin/mongo #{node.run_state['Primary_Mongo']} --quiet --eval \"printjsononeline(rs.add(\'#{node['ipaddress']}:27017\'))\"")
    tmpcmd = Mixlib::ShellOut.new("/opt/mongodb/bin/mongo #{node.run_state['Primary_Mongo']} --quiet --eval \"printjsononeline(rs.add(\'#{node['ipaddress']}:27017\'))\"").run_command
#Chef::Log.warn("***** output: " + tmpcmd.stdout)
  end
  action :nothing
end

#Chef::Log.warn("**********************End Repl Dev Block")
