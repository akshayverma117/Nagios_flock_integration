# Nagios & Flock Integration


##### Nagios
Nagios, now known as Nagios Core, is a free and open source computer-software application that monitors systems, networks and infrastructure. Nagios offers monitoring and alerting services for servers, switches, applications and services. Nagios monitors your entire IT infrastructure to ensure systems, applications, services, and business processes are functioning properly. In the event of a failure, Nagios can alert technical staff of the problem, allowing them to begin remediation processes before outages affect business processes, end-users, or customers. Nagios basically collects the statistics of your server (either using agent like nrpe,check_mk or via snmp ) and send the alert to you if the value of the metric is above some predefined threshold. Nagios after every interval checks the status of a remote service by executing a plugin, that will be placed on the remote client.
Using Nagios, you can:
- Plan for infrastructure upgrades before outdated systems cause failures
- Respond to issues at the first sign of a problem
- Automatically fix problems when they are detected
- Coordinate technical team responses
- Ensure your organization’s SLAs are being met
- Ensure IT infrastructure outages have a minimal effect on your organization’s bottom line
- Monitor your entire infrastructure and business processes

##### Flock
Flock is a messaging and collaboration tool, founded by tech entrepreneur Bhavin Turakhia in 2014. The app is available on Windows, MacOS, Android, iOS and Web. Flock allows users to configure external apps and integrations from the Flock App Store, and receive notifications and updates directly in Flock.

###### Instructions
- create files
```sh
$ vim /usr/local/bin/flock_nagios_host.sh  
```
```sh
$ vim /usr/local/bin/flock_nagios_service.sh  
```
- change permissions
```sh
sudo chmod 655 /usr/local/bin/flock_nagios_host.sh
sudo chmod 655 /usr/local/bin/flock_nagios_service.sh
```
- Check for errors
```sh
sudo nagios3 -v /etc/nagios3/nagios.cfg
```
- edit
```sh 
vim /etc/nagios3/commands.cfg
```
```sh 
# 'notify-service-by-flock' command definition
define command {
   	command_name 	notify-service-by-flock
   	command_line  	/usr/local/bin/flock_nagios_service.sh > /tmp/flock.log 2>&1
}

# 'notify-host-by-flock' command definition
define command {
   	command_name 	notify-host-by-flock
   	command_line  	/usr/local/bin/flock_nagios_host.sh > /tmp/flock.log 2>&1

}
```
- edit
```sh 
vim /etc/nagios3/conf.d/contacts_nagios2.cfg 
```
```sh
define contact {
   	contact_name                 	flock
   	alias                        	flock
   	service_notification_period  	24x7
   	host_notification_period     	24x7
   	service_notification_options 	w,u,c,r
   	host_notification_options    	d,r
   	service_notification_commands	notify-service-by-flock
   	host_notification_commands   	notify-host-by-flock
   	}


define contactgroup{
    	contactgroup_name   	admins-page
    	alias               	Nagios Administrators
    	members             	root,flock
}
```
