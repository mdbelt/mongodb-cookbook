#
# Cookbook Name:: mongodb
# Recipe:: replicaset
#
# Copyright 2015, Michael Belt
#

ruby_block "Does_Current_Need_Repl_Work" do
  block do
#Search for error 94.  Non initiated (or not added) to RS
    cmd = Mixlib::ShellOut.new("mongo #{node['ipaddress']}:#{node['mongodb']['port']} --quiet --eval 'rs.status()[\"code\"]'")
    status = cmd.run_command.stdout.strip
    if status.eql?("94")
      notifies :run, resources(:ruby_block => "Search_For_Primary"), :immediately
    end
  end
end

ruby_block "Initiate_Current_Node" do
  block do
#Initiate the RS on current node
    Mixlib::ShellOut.new("mongo #{node['ipaddress']}:#{node['mongodb']['port']} --quiet --eval 'printjsononeline(rs.initiate())'").run_command
  end
  action :nothing
end

ruby_block "Search_For_Primary" do
  block do
#Search for existing primary node.  Use Search criteria.
#TODO attribute the criteria & port to look on
    node.run_state['Primary_Mongo'] = ""
    Chef::Search::Query.new.search(:node, node['mongodb']['replicaset']['chef_search'])[0].each do |n|
      node.run_state['Primary_Mongo'] = Mixlib::ShellOut.new("mongo #{n['hostname']}:#{n['mongodb']['port']} --quiet --eval 'rs.status().members.forEach(function(z){if(z.stateStr == \"PRIMARY\")print(z.name);})'").run_command.stdout.strip
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
    tmpcmd = Mixlib::ShellOut.new("mongo #{node.run_state['Primary_Mongo']} --quiet --eval \"printjsononeline(rs.add(\'#{node['ipaddress']}:#{node['mongodb']['port']}\'))\"").run_command
  end
  action :nothing
end
