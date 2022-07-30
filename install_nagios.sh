#!/bin/bash
sudo amazon-linux-extras install epel -y
sudo yum install nagios nrpe nagios-plugins-all
sudo chkconfig -–level 3 nagios on
sudo service httpd start
sudo chkconfig httpd on
sudo yum install php
#edit

sudo /usr/sbin/nagios -v /etc/nagios/nagios.cfg

sudo service nagios start




