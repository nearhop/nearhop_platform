#!/bin/sh
/sbin/uci batch << EOI
set firewall.vpnforward=forwarding
set firewall.vpnforward.src=vpn
set firewall.vpnforward.dest=wan
set firewall.vpnforwardlan=forwarding
set firewall.vpnforwardlan.src=vpn
set firewall.vpnforwardlan.dest=lan
set firewall.vpnzone=zone
set firewall.vpnzone.name=vpn
del_list firewall.vpnzone.network=vpn
add_list firewall.vpnzone.network=vpn
set firewall.vpnzone.input=ACCEPT
set firewall.vpnzone.output=ACCEPT
set firewall.vpnzone.forward=ACCEPT
EOI
/sbin/uci commit
/sbin/uci batch << EOI
set network.vpn=interface
set network.vpn.device=tun1
set network.vpn.proto=udp
EOI
/sbin/uci commit
