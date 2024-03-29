#!/bin/bash

block_torrent () {
mainportsseve () {
unset seveports
seveports_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $seveports|grep "$var1 $var2")" ]] || seveports+="$var1 $var2\n"
done <<< "$seveports_var"
i=1
echo -e "$seveports"
}
fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
}
projectseve="${cor[1]} =================================== ${cor[0]}"
[[ -e /etc/adm-lite/idioma_menuinst ]] && id="$(cat /etc/adm-lite/idioma_menuinst)" || id=pt
[[ $(iptables -h|wc -l) -lt 5 ]] && apt-get install iptables -y > /dev/null 2>-1
NIC=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)

# THIS IS FUN IP

fun_ip
echo 'iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t filter -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT' > ./torrent-adm
chmod +x ./torrent-adm
# VIA TORRENT DNS BLOCK
echo 'iptables -A OUTPUT -p tcp --dport 53 -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -m state --state NEW -j ACCEPT' >> ./torrent-adm
# DHCP
echo 'iptables -A OUTPUT -p tcp --dport 67 -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p udp --dport 67 -m state --state NEW -j ACCEPT' >> ./torrent-adm
# Activate Services
list_ips=$(mainportsseve|awk '{print $2}')
while read PORT; do
echo "iptables -A INPUT -p tcp --dport $PORT -j ACCEPT
iptables -A INPUT -p udp --dport $PORT -j ACCEPT
iptables -A OUTPUT -p tcp --dport $PORT -j ACCEPT
iptables -A OUTPUT -p udp --dport $PORT -j ACCEPT
iptables -A FORWARD -p tcp --dport $PORT -j ACCEPT
iptables -A FORWARD -p udp --dport $PORT -j ACCEPT
iptables -A OUTPUT -p tcp -d $IP --dport $PORT -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p udp -d $IP --dport $PORT -m state --state NEW -j ACCEPT" >> ./torrent-adm
done <<< "$list_ips"
#Bloqueando Ping
echo 'iptables -A INPUT -p icmp --icmp-type echo-request -j DROP' >> ./torrent-adm
# Webmin via TORRENT
echo 'iptables -A INPUT -p tcp --dport 10000 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 10000 -j ACCEPT' >> ./torrent-adm
# NOW BLOCK TORRENT
echo "iptables -t nat -A PREROUTING -i $NIC -p tcp --dport 6881:6889 -j DNAT --to-dest $IP
iptables -A FORWARD -p tcp -i $NIC --dport 6881:6889 -d $IP -j REJECT
iptables -A OUTPUT -p tcp --dport 6881:6889 -j DROP
iptables -A OUTPUT -p udp --dport 6881:6889 -j DROP" >> ./torrent-adm
echo 'iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP' >> ./torrent-adm
./torrent-adm
echo -e "$projectseve\n $(source trans -b pt:${id} "YESSSS DONE")\n$projectseve"
}



[[ "$1" = "15" ]] && block_torrent


protection.sh
block_torrent
iptables-restore < /etc/iptables.conf