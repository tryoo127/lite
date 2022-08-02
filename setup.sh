#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
clear
echo ""
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;100;33m  MULTIPORT SCRIPT LITE BY XoolVPN       \E[0m"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 3
clear
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green    MASUKKAN DOMAIN (sub.yourdomain.com) $NC"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -p " Hostname / Domain: " host
mkdir -p /etc/rare
mkdir -p /etc/rare/xray
mkdir -p /etc/rare/v2ray
mkdir -p /etc/rare/tls
mkdir -p /etc/rare/config-url
mkdir -p /etc/rare/config-user
mkdir -p /etc/rare/xray/conf
mkdir -p /etc/rare/v2ray/conf
mkdir -p /etc/systemd/system/
mkdir -p /var/log/xray/
mkdir -p /var/log/v2ray/
mkdir /var/lib/premium-script;
touch /etc/rare/xray/clients.txt
touch /etc/rare/v2ray/clients.txt
echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
echo "$host" >> /etc/rare/xray/domain
echo "$host" >> /root/domain
clear
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green    PROCESS UPDATE & UPGRADE SEDANG DIJALANKAN  $NC"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
apt-get update && apt-get upgrade -y && update-grub -y
clear
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALL CERT & INSTALL DOMAIN     $NC"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
wget https://raw.githubusercontent.com/tryoo127/lite/main/ins-vt.sh && chmod +x ins-vt.sh && screen -S v2ray ./ins-vt.sh
wget https://raw.githubusercontent.com/tryoo127/lite/main/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
wget https://raw.githubusercontent.com/tryoo127/lite/main/xray-go.sh && chmod +x xray-go.sh && screen -S xray-go ./xray-go.sh
wget https://raw.githubusercontent.com/tryoo127/lite/main/v2ray-go.sh && chmod +x v2ray-go.sh && screen -S v2ray-go ./v2ray-go.sh

rm -f /root/ins-vt.sh
rm -f /root/xray-go.sh
rm -f /root/v2ray-go.sh


cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://tryoo.xyz

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
wget -O /etc/set.sh "https://raw.githubusercontent.com/tryoo127/lite/main/set.sh"
chmod +x /etc/set.sh
history -c
clear
echo " "
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green         INSTALLATION HAS BEEN COMPLETED!!          $NC"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
echo " "
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;100;33m     • MULTIPORT SCRIPT LITE BY XoolVPN •           \E[0m"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo "   - XRAY VLESS XTLS SPLICE  : 443"  | tee -a log-install.txt
echo "   - XRAY VLESS XTLS DIRECT  : 443"  | tee -a log-install.txt
echo "   - XRAY VLESS WS TLS       : 443"  | tee -a log-install.txt
echo "   - XRAY TROJAN TLS         : 443"  | tee -a log-install.txt
echo "   - XRAY VMESS TLS          : 443"  | tee -a log-install.txt
echo "   - V2RAY VLESS TLS SPLICE  : 80"   | tee -a log-install.txt
echo "   - V2RAY VLESS TLS DIRECT  : 80"   | tee -a log-install.txt
echo "   - V2RAY VLESS NONE TLS    : 80"   | tee -a log-install.txt
echo "   - V2RAY TROJAN TLS        : 80"   | tee -a log-install.txt
echo "   - V2RAY VMESS TLS         : 80"   | tee -a log-install.txt
echo ""
echo -e "\e[33m━━━━━━━[\e[0m \e[32mSayang Ibu Ayah\e[0m \e[33m]━━━━━━\e[0m"
echo ""
echo -e ""
sleep 3
echo -e ""
rm -f /root/setup.sh
rm -f /root/.bash_history
echo -ne "[ ${yell}WARNING${NC} ] Sila tekan (Y) dan Enter "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
