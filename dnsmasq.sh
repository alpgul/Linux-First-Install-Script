

sudo apt-get install dnsmasq
cat <<EOF >> /etc/dnsmasq.conf
interface=lo,ap0
no-dhcp-interface=lo,wlan0
bind-interfaces
server=127.0.0.1#40
dhcp-range=192.168.50.50,192.168.50.150,12h
EOF
