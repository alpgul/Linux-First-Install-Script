#!/bin/bash
# dnscrypt Server
if [ $SUDO_USER ]; 
then 
	user=$SUDO_USER;echo 
else 
	echo "Must be run as root user!!" 
	exit 1 
fi
cd /tmp
wget https://github.com/jedisct1/dnscrypt-proxy/releases/download/2.0.16/dnscrypt-proxy-linux_arm-2.0.16.tar.gz
sudo chmod +x dnscrypt-proxy-linux_arm-2.0.16.tar.gz
sudo mkdir /opt/dnscrypt-proxy
sudo tar xzf /tmp/dnscrypt-proxy-linux_arm-2.0.16.tar.gz -C /opt/dnscrypt-proxy
cd /opt/dnscrypt-proxy/linux-arm
sudo cp example-dnscrypt-proxy.toml dnscrypt-proxy.toml
sudo apt-get remove resolvconf -y
sudo cp /etc/resolv.conf /etc/resolv.conf.backup
sudo sed -i "s#listen_addresses = \['127.0.0.1:53', '\[::1\]:53'#listen_addresses = ['127.0.0.1:40', '[::1]:40'#" /opt/dnscrypt-proxy/linux-arm/dnscrypt-proxy.toml
sudo ./dnscrypt-proxy -service install
sudo ./dnscrypt-proxy -service start
sudo /etc/init.d/networking restart
