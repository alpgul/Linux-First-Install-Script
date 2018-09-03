#!/bin/bash
# Raspberry Monitor
if [ $SUDO_USER ]; 
then 
	user=$SUDO_USER;echo 
else 
	echo "Must be run as root user!!" 
	exit 1 
fi
cd /tmp
sudo apt-get install dirmngr
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F
sudo wget http://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list
sudo apt-get update
sudo apt-get install rpimonitor
sudo sed -i  "s#\#include=/etc/rpimonitor/template/services.conf#include=/etc/rpimonitor/template/services.conf#g" /etc/rpimonitor/data.conf
sudo sed -i  "s#\#include=/etc/rpimonitor/template/wlan.conf#include=/etc/rpimonitor/template/wlan.conf#g" /etc/rpimonitor/data.conf
sudo wget https://raw.githubusercontent.com/alpgul/Linux-First-Install-Script/master/RpiMonitor/Services.conf -O /etc/rpimonitor/template/services.conf
sudo service rpimonitor restart
sudo service rpimonitor update
