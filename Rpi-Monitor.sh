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
sudo wget https://goo.gl/yDYFhy -O rpimonitor_latest.deb
sudo chmod +x rpimonitor_latest.deb
sudo aptitude -y install librrds-perl libhttp-daemon-perl libjson-perl \
libipc-sharelite-perl libfile-which-perl libsnmp-extension-passpersist-perl
sudo dpkg -i rpimonitor_latest.deb
sudo /usr/share/rpimonitor/scripts/updatePackagesStatus.pl
sudo sed -i  "s#\#include=/etc/rpimonitor/template/services.conf#include=/etc/rpimonitor/template/services.conf#g" /etc/rpimonitor/data.conf
sudo sed -i  "s#\#include=/etc/rpimonitor/template/wlan.conf#include=/etc/rpimonitor/template/wlan.conf#g" /etc/rpimonitor/data.conf
sudo wget https://raw.githubusercontent.com/alpgul/Linux-First-Install-Script/master/RpiMonitor/Services.conf -O /etc/rpimonitor/template/services.conf
sudo service rpimonitor restart
sudo service rpimonitor update
