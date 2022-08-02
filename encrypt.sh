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
shc -r -f add-host
shc -r -f bbr
shc -r -f certv2ray
shc -r -f clear-log
shc -r -f clearcache
shc -r -f ins-vt
shc -r -f kernel-updt
shc -r -f m-domain
shc -r -f m-system
shc -r -f menu
shc -r -f resett
shc -r -f restart
shc -r -f setup
shc -r -f ssh-vpn
shc -r -f status
shc -r -f v2ray-go
shc -r -f v2ray-menu
shc -r -f v2ray-xp
shc -r -f vpsinfo
shc -r -f xp
shc -r -f xray-go
shc -r -f xray-menu
shc -r -f xray-xp

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
rm -r -f *.x.c
clear
echo -e "Encrypt Successfull..." | lolcat 
rm -r -f encrypt
cd
rm -rf shc-4.0.2
rm -rf 4.0.2.tar.gz
rm -rf master.zip
rm -rf encrypt.sh
