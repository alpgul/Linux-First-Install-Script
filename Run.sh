
#!/bin/bash
# My first script

green=`tput setaf 2`
reset=`tput sgr0`
echo "${green}Update${reset}"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get clean
echo "${green}install samba${reset}"
sudo apt-get install samba samba-common-bin -y
echo "${green}install qbittorrent${reset}"
sudo apt-get install qbittorrent-nox -y
echo "${green}dnscrypt-proxy${reset}"
cd /tmp
 wget https://github.com/jedisct1/dnscrypt-proxy/releases/download/2.0.16/dnscrypt-proxy-linux_arm-2.0.16.tar.gz
 sudo chmod +x dnscrypt-proxy-linux_arm-2.0.16.tar.gz
sudo mkdir /opt/dnscrypt-proxy
sudo tar xzf /tmp/dnscrypt-proxy-linux_arm-2.0.16.tar.gz -C /opt/dnscrypt-proxy
cd /opt/dnscrypt-proxy/linux-arm
sudo cp example-dnscrypt-proxy.toml dnscrypt-proxy.toml
sudo apt-get remove resolvconf -y
sudo cp /etc/resolv.conf /etc/resolv.conf.backup
sudo ./dnscrypt-proxy -service install
sudo ./dnscrypt-proxy -service start
sudo /etc/init.d/networking restart
echo "${green}Install INTANG${reset}"
cd /opt
sudo git clone https://github.com/alpgul/INTANG
cd ./INTANG/
sudo ./install_deps.sh
sudo make
sudo cp INTANG.sh /etc/init.d/
sudo cp INTANG.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable INTANG.service
echo "${green}install squid${reset}"
sudo apt-get install squid -y
sudo cp /etc/squid/squid.conf /etc/squid/squidoriginal.conf.bak
sudo sed -i 's/#http_access allow localnet/http_access allow localnet/g' /etc/squid/squid.conf
sudo sed -i 's/#acl localnet src 192.168.0.0\/16/acl localnet src 192.168.1.0\/24/g' /etc/squid/squid.conf
sudo sed -i 's/# dns_v4_first off/dns_v4_first on/g' /etc/squid/squid.conf
sudo sed -i 's/# cache_mem 256 MB/cache_mem 256 MB/g' /etc/squid/squid.conf
sudo sed -i 's/# maximum_object_size 4 MB/Maximum_object_size 4096 MB/g' /etc/squid/squid.conf
sudo sed -i 's/# maximum_object_size_in_memory 512 KB/Maximum_object_size_in_memory 8192 KB/g' /etc/squid/squid.conf
sudo sed -i 's/#cache_dir ufs \/var\/spool\/squid 100 16 256/cache_dir ufs \/var\/spool\/squid 8192 16 256/g' /etc/squid/squid.conf
sudo service squid restart
echo "${green}install rpimonitor${reset}"
cd /tmp
sudo wget https://goo.gl/yDYFhy -O rpimonitor_latest.deb
sudo chmod +x rpimonitor_latest.deb
sudo aptitude install librrds-perl libhttp-daemon-perl libjson-perl \
libipc-sharelite-perl libfile-which-perl libsnmp-extension-passpersist-perl
sudo dpkg -i rpimonitor_latest.deb
sudo /usr/share/rpimonitor/scripts/updatePackagesStatus.pl
sudo sh -c "echo 'nameserver 127.0.0.1 \noptions edns0 single-request-reopen' > /etc/resolv.conf" 
sudo chattr +i /etc/resolv.conf
echo "${green}install raspap${reset}"
sudo wget -q https://git.io/voEUQ -O /tmp/raspap && bash /tmp/raspap
