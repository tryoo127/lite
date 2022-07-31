#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;100;33m  • SCRIPT MENU SAYANG IBU AYAH • \E[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""      
echo -e " [\e[36m•1\e[0m] XRAY CORE "
echo -e " [\e[36m•2\e[0m] V2RAY CORE "
echo -e " [\e[36m•3\e[0m] SYSTEM MENU "
echo -e " [\e[36m•4\e[0m] SERVER STATUS "
echo -e " [\e[36m•5\e[0m] VPS INFO "
echo -e " [\e[36m•6\e[0m] REBOOT "
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e   " Press x or [ Ctrl+C ] • To-Exit-Script"
echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; xray-menu ;;
2) clear ; v2ray-menu ;;
3) clear ; m-system ;;
4) clear ; status ;;
5) clear ; vpsinfo ;;
6) clear ; reboot ;;
x) exit ;;
esac
