#!/bin/bash
# Emby Media Server

cd /tmp/
wget https://github.com/MediaBrowser/Emby.Releases/releases/download/3.5.2.0/emby-server-deb_3.5.2.0_armhf.deb
sudo dpkg -i emby-server-deb_3.5.2.0_armhf.deb
service emby-server restart
