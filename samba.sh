#!/bin/bash
# Samba Server

if [ $SUDO_USER ]; 
then 
	user=$SUDO_USER;echo 
else 
	echo "Must be run as root user!!" 
	exit 1 
fi
sudo apt-get install samba samba-common-bin
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.old
sudo sed -i  '/\[global\]/a server string = File Server' /etc/samba/smb.conf
sudo sudo sed -i  '/\[global\]/a security = user' /etc/samba/smb.conf
sudo sed -i  '/\[global\]/a encrypt passwords = true' /etc/samba/smb.conf
sudo sed -i  '/\[global\]/a guest account = nobody' /etc/samba/smb.conf
sudo sed -i  '/\[global\]/a force user = pi' /etc/samba/smb.conf
sudo sed -i  '/\[global\]/a force group = pi' /etc/samba/smb.conf
sudo sed -i  '/\[global\]/a security = user' /etc/samba/smb.conf
sudo mkdir /home/pi/Shares
sudo mkdir /home/pi/Shares/guests
sudo mkdir /home/pi/Shares/public
sudo cat <<EOF >> /etc/samba/smb.conf
[Guests]
comment = Guest Network Share
path = /home/pi/Shares/guests
browsable = yes
guest ok = yes
writeable = yes

[Public]
comment = Public Users Share
path = /home/pi/Shares/public
valid users = %U
write list = %U
browsable = yes
guest ok = no
writable = yes

[Movies]
comment = Emby Movies Share
path = /home/pi/Shares/movies
valid users = %U
write list = %U
browsable = yes
guest ok = no
writable = yes
EOF
sudo smbpasswd -a root<<EOF
root
root
EOF
sudo smbpasswd -a pi<<EOF
raspberry
raspberry
EOF
sudo service smbd restart
