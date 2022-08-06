#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
DOM=$(cat /etc/rare/xray/domain)
clear
# Chek Status 
xtls_xray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
tls_v2ray_status=$(systemctl status v2ray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
trojan_server=$(systemctl status trojan | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
strgo=$(echo "${trgo}" | grep 'ActiveState=' | cut -f2 -d=)  

# Color Validation
yell='\e[33m'
RED='\033[0;31m'
NC='\e[0m'
GREEN='\e[31m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
clear

# Status Service XTLS XRAY
if [[ $xtls_xray_status == "running" ]]; then 
   status_xtls_xray="Running [ \033[32mOK\033[0m ]"
else
   status_xtls_xray="Not Running [ \e[31m❌\e[0m ]"
fi

# Status Service TLS V2RAY
if [[ $tls_v2ray_status == "running" ]]; then 
   status_tls_v2ray="Running [ \033[32mOK\033[0m ]"
else
   status_tls_v2ray="Not Running [ \e[31m❌\e[0m ]"
fi

# Status Service Trojan
if [[ $trojan_server == "running" ]]; then 
   status_virus_trojan="Running [ \033[32mOK\033[0m ]"
else
   status_virus_trojan="Not Running [ \e[31m❌\e[0m ]"
fi
echo -e "\033[0;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;37;46m        ◎ STATUS SERVICE ◎             \e[0m"
echo -e
echo -e " ◎ DOMAIN      : $DOM"
echo -e " ◎ IP ADDRESS  : $MYIP"
echo -e " ◎ XRAY CORE   : $status_xtls_xray"
echo -e " ◎ V2RAY CORE  : $status_tls_v2ray"
echo -e "\033[0;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;37;46m        ◎ VPN PANEL MENU ◎             \e[0m"
echo -e
echo -e " [1]\e[0m•\e[1;36mXRAY MENU\e[0m"

echo -e " [2]\e[0m•\e[1;36mV2RAY MENU\e[0m"

echo -e " [3]\e[0m•\e[1;36mSYSTEM MENU\e[0m"

echo -e " [4]\e[0m•\e[1;36mSERVER INFO\e[0m"

echo -e " [5]\e[0m•\e[1;36mSERVER REBOOT\e[0m"

echo -e
echo -e "\E[0;37;46m       ◎ Moded By XoolVPN ◎            \e[0m"
echo -e "\033[0;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e   " Press X • To-Exit-Script"
echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; xray-menu ;;
2) clear ; v2ray-menu ;;
3) clear ; m-system ;;
4) clear ; vpsinfo ;;
5) clear ; reboot ;;
x) exit ;;
esac
