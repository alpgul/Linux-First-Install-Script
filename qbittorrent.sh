#!/bin/bash
# Torrent Server

if [ $SUDO_USER ]; 
then 
	user=$SUDO_USER;echo 
else 
	echo "Must be run as root user!!" 
	exit 1 
fi
#sudo adduser qbtuser
sudo apt-get install qbittorrent-nox -y
cat <<EOF >> /etc/systemd/system/qbittorrent.service
[Unit]
Description=qBittorrent Daemon Service
After=network.target

[Service]
User=qbtuser
ExecStart=/usr/bin/qbittorrent-nox
ExecStop=/usr/bin/killall -w qbittorrent-nox

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo su qbtuser
sudo systemctl enable qbittorrent.service
sudo systemctl start qbittorrent.service



