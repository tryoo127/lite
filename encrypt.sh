#!/bin/bash

#Install SHC
apt-get install build-essential -y
wget -c https://github.com/neurobin/shc/archive/4.0.2.tar.gz
tar xzvf 4.0.2.tar.gz 
cd shc-4.0.2/
./configure 
make
make install


#Masuk Direktori
cd /usr/bin

#Encrypt File
shc -f add-host
shc -f bbr
shc -f certv2ray
shc -f clear-log
shc -f clearcache
shc -f ins-vt
shc -f kernel-updt
shc -f m-domain
shc -f m-system
shc -f menu
shc -f resett
shc -f restart
shc -f setup
shc -f ssh-vpn
shc -f status
shc -f v2ray-go
shc -f v2ray-menu
shc -f v2ray-xp
shc -f vpsinfo
shc -f xp
shc -f xray-go
shc -f xray-menu
shc -f xray-xp

#Move file
mv add-host.x addhost
mv bbr.x bbr
mv certv2ray.x certv2ray
mv clear-log.x clear-log
mv clearcache.x clearcache
mv ins-vt.x ins-vt
mv kernel-updt.x kernel-updt
mv m-domain.x m-domain
mv m-system.x m-system
mv menu.x menu
mv resett.x reset
mv restart.x restart
mv setup.x setup
mv ssh-vpn.x ssh-vpn
mv status.x status
mv v2ray-go.x v2ray-go
mv v2ray-menu.x v2ray-menu
mv v2ray-xp.x v2ray-xp
mv vpsinfo.x vpsinfo
mv xp.x xp
mv xray-go.x xray-go
mv xray-menu.x xray-menu
mv xray-xp.x xray-xp

#Remove Extension
rm -f *.x.c
clear
echo -e "Encrypt Shell Susuccessful..." | lolcat
rm -f encrypt
cd
rm -rf shc-4.0.2
rm -rf 4.0.2.tar.gz
rm -rf master.zip