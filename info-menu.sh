#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
clear
sttt=`cat /root/log-install.txt`
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
IPVPS=$(curl -s ipinfo.io/ip )
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \E[0;100;33m        • Multi Port Script Lite by Tryoo •          \E[0m"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ":

   Isp Name : $ISP
   City     : $CITY
   Time     : $WKT
   IPVPS    : $IPVPS
   
\033[1;33mTerimalah Kasih\e[0m
"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m
\033[1;32mPort Information\e[0m :

$sttt

\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m

[\033[0;32m01\e[0m] • Show VPS Informatin

[00] • Back to Main Menu \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m"
echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
echo ""
echo -ne "Select menu : "; read x

case "$x" in 
   1 | 01)
   clear
   vpsinfo
   read -n 1 -s -r -p "Press any key to back on menu"
   info-menu
   ;;
   
   0 | 00)
   clear
   menu
   ;;
   *)
   info-menu
esac

#fim
