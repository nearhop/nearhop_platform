#!/bin/sh
topause=$1

pause="pauseall"
vpnpause="vpnpauseall"
if [ 0$topause -eq 1 ]; then
	/sbin/uci batch << EOI
set firewall.$pause=rule
set firewall.$pause.name="$pause"
set firewall.$pause.src=lan
set firewall.$pause.dest=wan
set firewall.$pause.target=REJECT
EOI
	/sbin/uci batch << EOI
set firewall.$vpnpause=rule
set firewall.$vpnpause.name="pauseallvpn"
set firewall.$vpnpause.src=vpn
set firewall.$vpnpause.dest=wan
set firewall.$vpnpause.target=REJECT
EOI
else 
	/sbin/uci delete firewall.$pause
	/sbin/uci delete firewall.$vpnpause
fi
/sbin/uci commit
/etc/init.d/firewall reload
