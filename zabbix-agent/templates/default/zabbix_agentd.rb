# This is a config file for the Zabbix agent daemon (Unix)
# To get more information about Zabbix, visit http://www.zabbix.com
############ GENERAL PARAMETERS #################
PidFile=/var/run/zabbix/zabbix_agentd.pid
LogFile=/var/log/zabbix/zabbix_agentd.log
LogFileSize=0
DebugLevel=3
Server=<%= node['zabbix-agent']['hostname'] %>
ListenPort=10050
ListenIP=<%= node[:opsworks][:instance][:private_ip] %>
StartAgents=3
ServerActive=<%= node['zabbix-agent']['hostname'] %>
Hostname=<%= node[:opsworks][:layers][:layershostname] %> - <%= node[:opsworks][:layers][:aws_instance_id] %>
HostMetadata=<%= node['zabbix-agent']['hostmetadata'] %>
Include=/etc/zabbix/zabbix_agentd.d/
UserParameter=check-port[*],/etc/zabbix/scripts/check-port.sh $1 $2
UserParameter=check-service[*],/etc/zabbix/scripts/check-service.sh $1
UserParameter=ntp.status,/etc/zabbix/scripts/check-ntp.sh
