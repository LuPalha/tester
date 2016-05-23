# This is a config file for the Zabbix agent daemon (Unix)
# To get more information about Zabbix, visit http://www.zabbix.com
############ GENERAL PARAMETERS #################
PidFile=/var/run/zabbix/zabbix_agentd.pid
LogFile=/var/log/zabbix/zabbix_agentd.log
LogFileSize=0
DebugLevel=3
Server=mon-int.bioritmo.net.br
ListenPort=10050
ListenIP=<%= node[:opsworks][:instance][:private_ip] %>
StartAgents=3
ServerActive=<%= node['zabbix-agent']['hostname'] %>
Hostname=<%= node[:opsworks][:stack][:name] %> - <%= node[:opsworks][:instance][:aws_instance_id] %>
HostMetadata=<%= node[:opsworks][:stack][:name] %>
Include=/etc/zabbix/zabbix_agentd.d/
