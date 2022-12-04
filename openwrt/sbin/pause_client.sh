#!/bin/sh
mac=$1
ip=$2
pause=$3

mac=`echo $mac | tr ':' '_'`
vpnmac="vpn"$mac
if [ 0$pause -eq 1 ]; then
	/sbin/uci batch << EOI
set firewall.$mac=rule
set firewall.$mac.name="$mac"
set firewall.$mac.src=lan
set firewall.$mac.dest=wan
set firewall.$mac.src_mac=$1
set firewall.$mac.target=REJECT
EOI
	/sbin/uci batch << EOI
set firewall.$vpnmac=rule
set firewall.$vpnmac.name="$vpnmac"
set firewall.$vpnmac.src=vpn
set firewall.$vpnmac.dest=wan
set firewall.$vpnmac.src_mac=$1
set firewall.$vpnmac.target=REJECT
EOI
# Remove if there are any existing rules
	iptables -D zone_lan_forward -m mac --mac-source $1 -m comment --comment "!fw3: $mac" -j zone_wan_dest_REJECT
	iptables -I zone_lan_forward 1 -m mac --mac-source $1 -m comment --comment "!fw3: $mac" -j zone_wan_dest_REJECT
else 
	/sbin/uci delete firewall.$mac
	/sbin/uci delete firewall.$vpnmac
	iptables -D zone_lan_forward -m mac --mac-source $1 -m comment --comment "!fw3: $mac" -j zone_wan_dest_REJECT
fi
/sbin/uci commit firewall
/etc/init.d/firewall reload
