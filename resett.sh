#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
clear 
echo -e "\033[0;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;37;46m        ◎ RESET SERVER ◎               \e[0m"
echo -e ""
echo -e "[ \033[32mInfo\033[0m ] RESET Begin"
systemctl daemon-reload
echo -e "[ \033[32mok\033[0m ] daemon-reload Service Restarted"
systemctl restart xray
echo -e "[ \033[32mok\033[0m ] xray Service Restarted"
systemctl restart xray.service
echo -e "[ \033[32mok\033[0m ] xray.service Service Restarted"
systemctl restart v2ray
echo -e "[ \033[32mok\033[0m ] v2ray Service Restarted"
systemctl restart v2ray.service
echo -e "[ \033[32mok\033[0m ] v2ray.service Service Restarted"
systemctl restart trojan
echo -e "[ \033[32mok\033[0m ] trojan Service Restarted"
systemctl restart nginx
echo -e "[ \033[32mok\033[0m ] nginx Service Restarted"
systemctl restart cron
echo -e "[ \033[32mok\033[0m ] cron Service Restarted"
systemctl restart fail2ban
echo -e "[ \033[32mok\033[0m ] fail2ban Service Restarted"
systemctl restart vnstat
echo -e "[ \033[32mok\033[0m ] vnstat Service Restarted"
sleep 1
echo -e "[ \033[32mInfo\033[0m ] ALL Service Reset"
echo ""
echo -e "\033[0;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on system menu"
m-system
