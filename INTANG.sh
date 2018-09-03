
cd /opt
sudo git clone https://github.com/alpgul/INTANG
cd ./INTANG/
sudo ./install_deps.sh
sudo make
sudo cp INTANG.sh /etc/init.d/
sudo cp INTANG.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable INTANG.service
