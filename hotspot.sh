
cat > /etc/systemd/network/08-wlan0.network <<EOF
[Match]
Name=wlan0
[Network]
Address=192.168.1.32/24
Gateway=192.168.1.1
EOF
cat > /etc/systemd/network/12-ap0.network <<EOF
[Match]
Name=ap0
[Network]
Address=192.168.50.1/24
DHCPServer=yes
IPForward=yes
EOF
sudo apt update
sudo apt install rng-tools hostapd -y
sudo systemctl stop hostapd
cat > /etc/hostapd/hostapd.conf <<EOF
interface=ap0
driver=nl80211
ssid=RPiNet
hw_mode=g
channel=4
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=verySecretPw
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
EOF
sudo chmod 600 /etc/hostapd/hostapd.conf
sudo sed -i 's/^#DAEMON_CONF=.*$/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/' /etc/default/hostapd
cat <<-'EOF' | sudo systemctl edit hostapd.service
[Service]
ExecStartPre=/sbin/iw dev wlan0 interface add ap0 type __ap
EOF
cat <<-'EOF' | sudo systemctl edit wpa_supplicant@wlan0.service
[Service]
ExecStartPost=/sbin/iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
ExecStop=/sbin/iptables -t nat -D POSTROUTING -o wlan0 -j MASQUERADE

[Unit]
After=hostapd.service
EOF
