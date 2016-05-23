#
# Cookbook Name:: zabbix-agent
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Recipe for Rails App Server
#

node[:deploy].each do |application, deploy|

case node[:platform]
    when 'redhat', 'centos', 'amazon'

execute 'zabbix_install_r' do
  Chef::Log.info("Downloading and installing zabbix")
  user 'root'
  command 'yum localinstall https://s3.amazonaws.com/bioritmo-zabbix-agent-receita/zabbix-release-2.4-1.el6.noarch.rpm -y && yum install zabbix-agent -y'
  action :run
end

   when 'ubuntu'

execute 'zabbix_install_u' do
  Chef::Log.info("Downloading and installing zabbix")
  user 'root'
  command 'cd /tmp && wget https://s3.amazonaws.com/bioritmo-zabbix-agent-receita/zabbix-release_2.4-1%2Btrusty_all.deb && dpkg -i zabbix-release_2.4-1+trusty_all.deb && apt-get update && apt-get install zabbix-agent && rm zabbix-release_2.4-1+trusty_all.deb'
  action :run
end

   when 'debian'

  execute 'zabbix_install_d' do
  Chef::Log.info("Downloading and installing zabbix")
  user 'root'
  command 'cd /tmp && wget https://s3.amazonaws.com/bioritmo-zabbix-agent-receita/zabbix-release_2.4-1%2Bwheezy_all.deb && dpkg -i zabbix-release_2.4-1+wheezy_all.deb && apt-get update && apt-get install zabbix-agent && rm zabbix-release_2.4-1+wheezy_all.deb'
  action :run
end

end

template '/etc/zabbix/zabbix_agentd.conf' do
  source 'zabbix_agentd.rb'
  owner 'zabbix'
  group 'zabbix'
  mode '0644'
end

directory '/etc/zabbix/scripts' do
 owner 'root'
 group 'root'
 mode '0755'
 action :create
end

template '/etc/zabbix/scripts/nginx.sh' do
  source 'nginx.erb'
  owner 'zabbix'
  group 'zabbix'
  mode '0755'
end

template '/etc/zabbix/scripts/unicorn.sh' do
  source 'unicorn.erb'
  owner 'zabbix'
  group 'zabbix'
  mode '0755'
  variables({ :app_name => "#{application}"})
end

template '/etc/zabbix/zabbix_agentd.d/userparameter_web-check.conf' do
  source 'userparameter_web-check.conf'
  owner 'zabbix'
  group 'zabbix'
  mode '0644'
end

service "zabbix-agent" do
  action [ :enable, :restart ]
end
end
