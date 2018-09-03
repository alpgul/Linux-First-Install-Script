


sudo apt-get install samba samba-common-bin
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.old
sed -i  '/\[global\]/a server string = File Server' /etc/samba/smb.conf
sed -i  '/\[global\]/a security = user' /etc/samba/smb.conf
sed -i  '/\[global\]/a encrypt passwords = true' /etc/samba/smb.conf
sed -i  '/\[global\]/a guest account = nobody' /etc/samba/smb.conf
sed -i  '/\[global\]/a force user = pi' /etc/samba/smb.conf
sed -i  '/\[global\]/a force group = pi' /etc/samba/smb.conf
sed -i  '/\[global\]/a security = user' /etc/samba/smb.conf
mkdir /home/pi/Shares
mkdir /home/pi/Shares/guests
mkdir /home/pi/Shares/public
cat <<EOF >> /etc/samba/smb.conf
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
sudo smbpasswd -a root
sudo smbpasswd -a pi
sudo service smbd restart
