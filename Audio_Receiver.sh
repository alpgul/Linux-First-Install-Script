

cd /tmp/
git clone https://github.com/BaReinhard/Super-Simple-Raspberry-Pi-Audio-Receiver-Install.git
cd Super-Simple-Raspberry-Pi-Audio-Receiver-Install
git checkout stretch-fix
sudo sed 's#if \[ "$GMedia" = "y" \]#if [ "$GMedia" = "n" ]#g' ./install.sh
sudo ./install.sh
