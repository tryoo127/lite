#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
clear
function add-user() {
	clear
        echo -e "==========-V2RAY/VLESS-=========="
         echo ""
	read -p "Username : " user
	if grep -qw "$user" /etc/rare/v2ray/clients.txt; then
		echo -e ""
		echo -e "User \e[31m$user\e[0m already exist"
		echo -e ""
		echo -e "================================="
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        v2ray-menu
	fi
    read -p "BUG TELCO : " BUG
	read -p "Duration (day) : " duration
	uuid=$(cat /proc/sys/kernel/random/uuid)
	exp=$(date -d +${duration}days +%Y-%m-%d)
	expired=$(date -d "${exp}" +"%d %b %Y")
	domain=$(cat /etc/rare/xray/domain)
	tls="$(cat ~/log-install.txt | grep -w "V2RAY VLESS TLS SPLICE" | cut -d: -f2|sed 's/ //g')"
	email=${user}@${domain}
    cat>/etc/rare/v2ray/tls.json<<EOF
      {
       "v": "2",
       "ps": "${user}",
       "add": "${BUG}.${domain}",
       "port": "${tls}",
       "id": "${uuid}",
       "aid": "0",
       "scy": "auto",
       "net": "ws",
       "type": "none",
       "host": "${BUG}",
       "path": "/v2rayvws",
       "tls": "tls",
       "sni": "${BUG}"
}
EOF
    vmess_base641=$( base64 -w 0 <<< $vmess_json1)
    vmesslink1="vmess://$(base64 -w 0 /etc/rare/v2ray/tls.json)"
	echo -e "${user}\t${uuid}\t${exp}" >> /etc/rare/v2ray/clients.txt
    cat /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds.json | jq '.inbounds[0].settings.clients += [{"id": "'${uuid}'","add": "'${domain}'","flow": "xtls-rprx-direct","email": "'${email}'"}]' > /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds_tmp.json /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds.json
    cat /etc/rare/v2ray/conf/03_VLESS_WS_inbounds.json | jq '.inbounds[0].settings.clients += [{"id": "'${uuid}'","email": "'${email}'"}]' > /etc/rare/v2ray/conf/03_VLESS_WS_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/03_VLESS_WS_inbounds_tmp.json /etc/rare/v2ray/conf/03_VLESS_WS_inbounds.json
    cat /etc/rare/v2ray/conf/04_trojan_TCP_inbounds.json | jq '.inbounds[0].settings.clients += [{"password": "'${uuid}'","email": "'${email}'"}]' > /etc/rare/v2ray/conf/04_trojan_TCP_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/04_trojan_TCP_inbounds_tmp.json /etc/rare/v2ray/conf/04_trojan_TCP_inbounds.json
    cat /etc/rare/v2ray/conf/05_VMess_WS_inbounds.json | jq '.inbounds[0].settings.clients += [{"id": "'${uuid}'","alterId": 0,"add": "'${domain}'","email": "'${email}'"}]' > /etc/rare/v2ray/conf/05_VMess_WS_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/05_VMess_WS_inbounds_tmp.json /etc/rare/v2ray/conf/05_VMess_WS_inbounds.json
	cat <<EOF >>"/etc/rare/config-user/${user}"
vless://$uuid@$BUG.$domain:$tls?flow=xtls-rprx-splice&encryption=none&security=tls&sni=$BUG&type=tcp&headerType=none&host=$BUG#$user
vless://$uuid@$BUG.$domain:$tls?flow=xtls-rprx-direct&encryption=none&security=tls&sni=$BUG&type=tcp&headerType=none&host=$BUG#$user
vless://$uuid@$BUG.$domain:$tls?encryption=none&security=$BUG&type=ws&host=$BUG&path=#$user
trojan://$uuid@$BUG.$domain:$tls?sni=$BUG#$user
${vmesslink1}
EOF
    cat <<EOF >>"/etc/rare/config-url/${user}"
  nameserver:
    - 119.29.29.29
    - 223.5.5.5
    - 180.76.76.76
  fallback:
    - https://doh.dns.sb/dns-query
    - tcp://208.67.222.222:443
    - tls://dns.google
  fallback-filter:
    geoip: true
    ipcidr:
      - 240.0.0.0/4
tproxy: true
tproxy-port: 23458
EOF
	base64Result=$(base64 -w 0 /etc/rare/config-user/${user})
    echo ${base64Result} >"/etc/rare/config-url/${uuid}"
    systemctl restart v2ray.service
    echo -e "\033[32m[Info]\033[0m v2ray Start Successfully !"
    sleep 2
    clear
	echo -e "==========-V2RAY/VLESS-=========="
	echo -e " USERNAME      : $user"
	echo -e " EXPIRED DATE  : $expired"
    echo -e " JUMLAH HARI   : $duration Hari"
    echo -e " PORT          : $tls"
    echo -e " USER UUID : $uuid"
    echo -e " IP VPS        : $MYIP"
    echo -e " DOMAIN        : $domain"
	echo -e " BUG DOMAIN    : $BUG"
    echo -e "================================="
	echo -e " Link VLESS SPLICE: vless://$uuid@$BUG.$domain:$tls?flow=xtls-rprx-splice&encryption=none&security=$BUG&type=tcp&headerType=none&host=$BUG#$user"
    echo -e "================================="
	echo -e " Link VLESS WS: vless://$uuid@$BUG.$domain:$tls?encryption=none&security=$BUG&type=ws&host=$BUG&path=#$user"
    echo -e "================================="
	echo -e " Link TROJAN: trojan://$uuid@$BUG.$domain:$tls?sni=$BUG#$user"
    echo -e "================================="
    echo -e " Link VMESS TLS: ${vmesslink1}"
	echo -e "================================="
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    v2ray-menu  
}

function delete-user() {
	clear
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m      • DELETE V2RAY USER •        \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""  
	read -p "Username : " user
	echo -e ""
	if ! grep -qw "$user" /etc/rare/v2ray/clients.txt; then
		echo -e ""
        echo -e "User \e[31m$user\e[0m does not exist"
        echo ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        v2ray-menu
	fi
    rm /etc/rare/config-url/${user}
	uuid="$(cat /etc/rare/v2ray/clients.txt | grep -w "$user" | awk '{print $2}')"
	cat /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.id == "'${uuid}'"))' > /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds_tmp.json /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds.json
    cat /etc/rare/v2ray/conf/03_VLESS_WS_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.id == "'${uuid}'"))' > /etc/rare/v2ray/conf/03_VLESS_WS_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/03_VLESS_WS_inbounds_tmp.json /etc/rare/v2ray/conf/03_VLESS_WS_inbounds.json
    cat /etc/rare/v2ray/conf/04_trojan_TCP_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.password == "'${uuid}'"))' > /etc/rare/v2ray/conf/04_trojan_TCP_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/04_trojan_TCP_inbounds_tmp.json /etc/rare/v2ray/conf/04_trojan_TCP_inbounds.json		
    cat /etc/rare/v2ray/conf/05_VMess_WS_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.id == "'${uuid}'"))' > /etc/rare/v2ray/conf/05_VMess_WS_inbounds_tmp.json
	mv -f /etc/rare/v2ray/conf/05_VMess_WS_inbounds_tmp.json /etc/rare/v2ray/conf/05_VMess_WS_inbounds.json
    sed -i "/\b$user\b/d" /etc/rare/v2ray/clients.txt
    rm /etc/rare/config-user/${user}
    rm /etc/rare/config-url/${uuid}
	systemctl restart v2ray.service
    echo -e "\033[32m[Info]\033[0m v2ray Start Successfully !"
    echo ""
	echo -e "User \e[32m$user\e[0m deleted Successfully !"
	echo ""
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    v2ray-menu 
}

function extend-user() {
	clear
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m      • EXTEND V2RAY USER •        \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
	read -p "Username : " user
	if ! grep -qw "$user" /etc/rare/v2ray/clients.txt; then
		echo -e ""
		echo -e "User \e[31m$user\e[0m does not exist"
        echo ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        v2ray-menu
	fi
	read -p "Duration (day) : " extend
	uuid=$(cat /etc/rare/v2ray/clients.txt | grep -w $user | awk '{print $2}')
	exp_old=$(cat /etc/rare/v2ray/clients.txt | grep -w $user | awk '{print $3}')
	diff=$((($(date -d "${exp_old}" +%s)-$(date +%s))/(86400)))
	duration=$(expr $diff + $extend + 1)
	exp_new=$(date -d +${duration}days +%Y-%m-%d)
	exp=$(date -d "${exp_new}" +"%d %b %Y")
	sed -i "/\b$user\b/d" /etc/rare/v2ray/clients.txt
	echo -e "$user\t$uuid\t$exp_new" >> /etc/rare/v2ray/clients.txt
	clear
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m   • V2RAY USER INFORMATION •      \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
	echo -e "Username     : $user"
	echo -e "Expired date : $exp"
	echo -e ""
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    v2ray-menu   
}

function user-list() {
	clear
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m       • V2RAY USER LIST •         \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    echo -e  "\e[36mUsername               Exp. Date\e[0m"
    echo ""    
	while read expired
	do
		user=$(echo $expired | awk '{print $1}')
		exp=$(echo $expired | awk '{print $3}')
		exp_date=$(date -d"${exp}" "+%d %b %Y")
		printf "%-17s %2s\n" "$user" "     $exp_date"
	done < /etc/rare/v2ray/clients.txt
	total=$(wc -l /etc/rare/v2ray/clients.txt | awk '{print $1}')
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "Total accounts: $total"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	echo -e ""
    read -n 1 -s -r -p "Press any key to back on menu"
    v2ray-menu
}

function user-monitor() {
	clear
	echo -n > /tmp/other.txt
	data=($(cat /etc/rare/v2ray/clients.txt | awk '{print $1}'));
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m     • V2RAY USER MONITOR •        \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
	for akun in "${data[@]}"
	do
	if [[ -z "$akun" ]]; then
	akun="tidakada"
	fi
	echo -n > /tmp/ipvmess.txt
	data2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep v2ray | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
	for ip in "${data2[@]}"
	do
	jum=$(cat /var/log/v2ray/access.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
    if [[ "$jum" = "$ip" ]]; then
	echo "$jum" >> /tmp/ipvmess.txt
	else
	echo "$ip" >> /tmp/other.txt
	fi
	jum2=$(cat /tmp/ipvmess.txt)
	sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
	done
	jum=$(cat /tmp/ipvmess.txt)
	if [[ -z "$jum" ]]; then
	echo > /dev/null
	else
	jum2=$(cat /tmp/ipvmess.txt | nl)
	echo "user : $akun";
	echo "$jum2";
    echo -e  "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	fi
	rm -rf /tmp/ipvmess.txt
	done
	oth=$(cat /tmp/other.txt | sort | uniq | nl)
	echo "other";
	echo "$oth";
	echo -e  "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	rm -rf /tmp/other.txt
	echo -e ""
    read -n 1 -s -r -p "Press any key to back on menu"
    v2ray-menu     
}

function show-config() {
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m      • V2RAY USER CONFIG •        \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""
	read -p "User : " user
	if ! grep -qw "$user" /etc/rare/v2ray/clients.txt; then
		echo -e ""
		echo -e "User \e[31m$user\e[0m does not exist"
		echo -e ""
        read -n 1 -s -r -p "Press any key to back on menu"
        v2ray-menu
	fi
    tls="$(cat ~/log-install.txt | grep -w "V2RAY VLESS TLS SPLICE" | cut -d: -f2|sed 's/ //g')"
    link=$(cat /etc/rare/config-user/${user})
	uuid=$(cat /etc/rare/v2ray/clients.txt | grep -w "$user" | awk '{print $2}')
	domain=$(cat /etc/rare/xray/domain)
	exp=$(cat /etc/rare/v2ray/clients.txt | grep -w "$user" | awk '{print $3}')
	exp_date=$(date -d"${exp}" "+%d %b %Y")

	clear
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m   • V2RAY USER INFORMATION •      \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"      
	echo -e ""
	echo -e " Username      : $user"
	echo -e " Expired date  : $exp_date"
	echo -e " Ip Vps        : $MYIP"
    echo -e " Domain        : $domain"
    echo -e " PORT          : $tls"
    echo -e " UUID/PASSWORD : $uuid"
	echo -e ""
    echo -e " Config :"
	echo -e " $link"  
	echo -e ""
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    v2ray-menu    
}

function change-port() {
	clear
    tls="$(cat ~/log-install.txt | grep -w "V2RAY VLESS TLS SPLICE" | cut -d: -f2|sed 's/ //g')"
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m      • CHANGE PORT V2RAY •        \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""
	echo -e "Change Port V2RAY TCP TLS: $tls"
	echo -e ""
	read -p "New Port V2RAY TCP TLS: " tls1
	if [ -z $tls1 ]; then
	echo "Please Input Port"
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    change-port 
	fi
	cek=$(netstat -nutlp | grep -w $tls1)
    if [[ -z $cek ]]; then
    sed -i "s/$tls/$tls1/g" /etc/rare/v2ray/conf/02_VLESS_TCP_inbounds.json
    sed -i "s/   - V2RAY VLESS TLS SPLICE  : $tls/   - V2RAY VLESS TLS SPLICE  : $tls1/g" /root/log-install.txt
    sed -i "s/   - V2RAY VLESS TLS DIRECT  : $tls/   - V2RAY VLESS TLS DIRECT  : $tls1/g" /root/log-install.txt
    sed -i "s/   - V2RAY VLESS WS TLS      : $tls/   - V2RAY VLESS WS TLS      : $tls1/g" /root/log-install.txt
    sed -i "s/   - V2RAY TROJAN TLS        : $tls/   - V2RAY TROJAN TLS        : $tls1/g" /root/log-install.txt
    sed -i "s/   - V2RAY VMESS TLS         : $tls/   - V2RAY VMESS TLS         : $tls1/g" /root/log-install.txt
    iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tls -j ACCEPT
    iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tls -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tls1 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tls1 -j ACCEPT
    iptables-save > /etc/iptables.up.rules
    iptables-restore -t < /etc/iptables.up.rules
    netfilter-persistent save > /dev/null
    netfilter-persistent reload > /dev/null
    systemctl restart v2ray > /dev/null
    echo -e "\033[32m[Info]\033[0m v2ray Start Successfully !"
    echo ""
    echo -e "\e[032;1mPort $tls1 modified Successfully !\e[0m"
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    v2ray-menu    
    else
    echo "Port $tls1 is used"
	echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    change-port    
    fi
}

clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;100;33m      • V2RAY CORE MENU •          \E[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""      
echo -e " [\e[36m•1\e[0m] Add V2RAY user "
echo -e " [\e[36m•2\e[0m] Delete V2RAY user "
echo -e " [\e[36m•3\e[0m] Extend V2RAY user "
echo -e " [\e[36m•4\e[0m] View user list "
echo -e " [\e[36m•5\e[0m] Monitor user "
echo -e " [\e[36m•6\e[0m] Show User config "
echo -e " [\e[36m•7\e[0m] Change Port V2RAY "
echo -e ""
echo -e " [\e[31m•0\e[0m] \e[31mBACK TO MENU\033[0m"
echo -e   ""
echo -e   "Press x or [ Ctrl+C ] • To-Exit"
echo -e   ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; add-user ;;
2) clear ; delete-user ;;
3) clear ; extend-user ;;
4) clear ; user-list ;;
5) clear ; user-monitor ;;
6) clear ; show-config ;;
7) clear ; change-port ;;
0) clear ; menu ;;	
x) exit ;;
*) echo -e "" ; echo "Terimalah Kasih" ; sleep 1 ; v2ray-menu ;;
esac
