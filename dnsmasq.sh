

sudo apt-get install dnsmasq
cat <<EOF >> /etc/dnsmasq.conf
# disables dnsmasq reading any other files like /etc/resolv.conf for nameservers
no-resolv
# Interface to bind to
interface=wlan0
# Specify starting_range,end_range,lease_time
dhcp-range=192.168.50.3,192.168.50.20,12h
# dns addresses to send to the clients
server=127.0.0.1#40
EOF
