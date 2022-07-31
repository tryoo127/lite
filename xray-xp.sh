#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
clear
today=$(date -d +1day +%Y-%m-%d)

while read expired
do
	user=$(echo $expired | awk '{print $1}')
	uuid=$(echo $expired | awk '{print $2}')
	exp=$(echo $expired | awk '{print $3}')

	if [[ $exp < $today ]]; then
		rm /etc/rare/config-url/${user}
		cat /etc/rare/xray/conf/02_VLESS_TCP_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.id == "'${uuid}'"))' > /etc/rare/xray/conf/02_VLESS_TCP_inbounds_tmp.json
		mv -f /etc/rare/xray/conf/02_VLESS_TCP_inbounds_tmp.json /etc/rare/xray/conf/02_VLESS_TCP_inbounds.json
		
		cat /etc/rare/xray/conf/03_VLESS_WS_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.id == "'${uuid}'"))' > /etc/rare/xray/conf/03_VLESS_WS_inbounds_tmp.json
		mv -f /etc/rare/xray/conf/03_VLESS_WS_inbounds_tmp.json /etc/rare/xray/conf/03_VLESS_WS_inbounds.json
		
		cat /etc/rare/xray/conf/04_trojan_TCP_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.password == "'${uuid}'"))' > /etc/rare/xray/conf/04_trojan_TCP_inbounds_tmp.json
		mv -f /etc/rare/xray/conf/04_trojan_TCP_inbounds_tmp.json /etc/rare/xray/conf/04_trojan_TCP_inbounds.json
		
		cat /etc/rare/xray/conf/05_VMess_WS_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.id == "'${uuid}'"))' > /etc/rare/xray/conf/05_VMess_WS_inbounds_tmp.json
		mv -f /etc/rare/xray/conf/05_VMess_WS_inbounds_tmp.json /etc/rare/xray/conf/05_VMess_WS_inbounds.json
		
		cat /etc/rare/xray/conf/06_VLESS_gRPC_inbounds.json | jq 'del(.inbounds[0].settings.clients[] | select(.id == "'${uuid}'"))' > /etc/rare/xray/conf/06_VLESS_gRPC_inbounds_temp.json
		mv -f /etc/rare/xray/conf/06_VLESS_gRPC_inbounds_temp.json /etc/rare/xray/conf/06_VLESS_gRPC_inbounds.json
		
		cat /etc/rare/xray/conf/vmess-nontls.json | jq 'del(settings.clients[] | select(.id == "'${uuid}'"))' > /etc/rare/xray/conf/vmess-nontls_tmp.json
	mv -f /etc/rare/xray/conf/vmess-nontls_tmp.json /etc/rare/xray/conf/vmess-nontls.json
	
	cat /etc/rare/xray/conf/vless-nontls.json | jq 'del(settings.clients[] | select(.id == "'${uuid}'"))' > /etc/rare/xray/conf/vless-nontls_tmp.json
	mv -f /etc/rare/xray/conf/vless-nontls_tmp.json /etc/rare/xray/conf/vless-nontls.json 
		
		sed -i "/\b$user\b/d" /etc/rare/xray/clients.txt
		rm /etc/rare/config-user/${user}
		rm /etc/rare/config-url/${uuid}
	fi
done < /etc/rare/xray/clients.txt
service xray restart
