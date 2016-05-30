#
# Cookbook Name:: zabbix-agent
# Recipe:: default
#
# Copyright 2016, Rivendel
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
    when 'redhat', 'centos', 'amazon'

execute 'zabbix_install_r' do
  Chef::Log.info("Downloading and installing zabbix")
  user 'root'
  command 'yum localinstall http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm -y && yum install zabbix-agent -y'
  action :run
end

   when 'ubuntu'

execute 'zabbix_install_u' do
  Chef::Log.info("Downloading and installing zabbix")
  user 'root'
  command 'cd /tmp && wget http://repo.zabbix.com/zabbix/2.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.4-1+trusty_all.deb && dpkg -i zabbix-release_2.4-1+trusty_all.deb && apt-get update && apt-get install zabbix-agent && rm zabbix-release_2.4-1+trusty_all.deb'
  action :run
end

   when 'debian'

  execute 'zabbix_install_d' do
  Chef::Log.info("Downloading and installing zabbix")
  user 'root'
  command 'cd /tmp && wget http://repo.zabbix.com/zabbix/2.4/debian/pool/main/z/zabbix-release/zabbix-release_2.4-1+wheezy_all.deb && dpkg -i zabbix-release_2.4-1+wheezy_all.deb && apt-get update && apt-get install zabbix-agent && rm zabbix-release_2.4-1+wheezy_all.deb'
  action :run
end

end

directory '/etc/zabbix/scripts' do
  owner "zabbix"
  group "zabbix"
  mode 00755
  action :create
end

template '/etc/zabbix/scripts/check-service.sh' do
  source 'check_service.sh'
  owner 'zabbix'
  group 'zabbix'
  mode '0755'
end

template '/etc/zabbix/scripts/check-port.sh' do
  source 'check_port.sh'
  owner 'zabbix'
  group 'zabbix'
  mode '0755'
end

template '/etc/zabbix/scripts/check-ntp.sh' do
  source 'check_port.sh'
  owner 'zabbix'
  group 'zabbix'
  mode '0755'
end

template '/etc/zabbix/zabbix_agentd.conf' do
  source 'zabbix_agentd.rb'
  owner 'zabbix'
  group 'zabbix'
  mode '0644'
end

service "zabbix-agent" do
  action [ :enable, :start ]
end

