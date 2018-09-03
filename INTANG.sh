#!/bin/bash
# INTANG Server
if [ $SUDO_USER ]; 
then 
	user=$SUDO_USER;echo 
else 
	echo "Must be run as root user!!" 
	exit 1 
fi
cd /opt
sudo git clone https://github.com/alpgul/INTANG
cd ./INTANG/
sudo ./install_deps.sh
sudo make
sudo cp INTANG.sh /etc/init.d/
sudo cp INTANG.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable INTANG.service
