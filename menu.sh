#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
clear
echo -e "\033[0;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;37;46m           ◎ 𝗩𝗣𝗡 𝗣𝗔𝗡𝗘𝗟 𝗠𝗘𝗡𝗨 ◎                      \e[0m"
echo -e
echo -e " [1]\e[0m•\e[1;36mXRAY MULTIPORT\e[0m"

echo -e " [2]\e[0m•\e[1;36mVLESS NONE TLS\e[0m"

echo -e " [3]\e[0m•\e[1;36mSYSTEM MENU\e[0m"

echo -e " [4]\e[0m•\e[1;36mSERVER INFO\e[0m"

echo -e " [5]\e[0m•\e[1;36mSERVER STATUS\e[0m"

echo -e " [6]\e[0m•\e[1;36mSERVER REBOOT\e[0m"

echo -e
echo -e "\E[0;37;46m           ◎ Moded By 𝑿𝒐𝒐𝒍𝚅𝙿𝙽 ◎                    \e[0m"
echo -e "\033[0;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e   " Press x or [ Ctrl+C ] • To-Exit-Script"
echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; xray-menu ;;
2) clear ; v2ray-menu ;;
3) clear ; m-system ;;
4) clear ; vpsinfo ;;
5) clear ; status ;;
6) clear ; reboot ;;
x) exit ;;
esac
