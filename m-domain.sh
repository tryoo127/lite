#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
clear 
echo -e "\033[0;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;37;46m        ◎ DOMAIN MENU ◎                  \e[0m"
echo -e "" 
echo -e " [1]\e[0m•\e[1;36mCHANGE DOMAIN\e[0m"
echo -e " [2]\e[0m•\e[1;36mADD ID CLOUDFLARE\e[0m"
echo -e " [3]\e[0m•\e[1;36mADD SUBDOMAIN\e[0m"
echo -e " [4]\e[0m•\e[1;36mPOINTING BUG\e[0m"
echo -e " [5]\e[0m•\e[1;36mRENEW CERTIFICATE\e[0m"
echo -e ""
echo -e " [\e[31m•0\e[0m] \e[31mBACK TO MENU\033[0m"
echo -e   ""
echo -e "\E[0;37;46m     ◎ Moded By XoolVPN ◎              \e[0m"
echo -e "\033[0;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e   " Press X • To-Exit-Script"
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; add-host ;;
2) clear ; cff ;;
3) clear ; cfd ;;
4) clear ; cfh ;;
5) clear ; certv2ray ;;
0) clear ; menu ;;
x) exit ;;
*) echo "Terimalah Kasih" ; sleep 1 ; m-domain ;;
esac
