#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
clear 
echo -e "\033[0;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;37;46m        ◎ SYSTEM MENU ◎                \e[0m"
echo -e ""
echo -e " [1]\e[0m•\e[1;36mPANEL DOMAIN\e[0m"
echo -e " [2]\e[0m•\e[1;36mCLEAR LOG\e[0m"
echo -e " [3]\e[0m•\e[1;36mCEK BANDWITH\e[0m"
echo -e " [4]\e[0m•\e[1;36mRESET SERVER\e[0m"
echo -e " [5]\e[0m•\e[1;36mKERNEL UPDATE\e[0m"
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
1) clear ; m-domain ; exit ;;
2) clear ; clear-log ; exit ;;
3) clear ; vnstat -d ; exit ;;
4) clear ; resett ; exit ;;
5) clear ; kernel-updt ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo -e "" ; echo "Terimalah Kasih" ; sleep 1 ; m-system ;;
esac
