#!/bin/sh

. /sbin/nh_common.sh
radio=$MESHRADIO
rule_name=$MESHIF
exists=`/sbin/uci get wireless.$rule_name.network`
if [ "$exists" != "" ]; then
	exit 0
fi
ssid=`tr -dc A-Za-z0-9 </dev/urandom | head -c 25`
key=`tr -dc A-Za-z0-9 </dev/urandom | head -c 25`
uci batch << EOI
set wireless.$rule_name=wifi-iface
set wireless.$rule_name.device=$radio
set wireless.$rule_name.network="lan"
set wireless.$rule_name.mode="mesh"
set wireless.$rule_name.mesh_fwding="1"
set wireless.$rule_name.key=$key
set wireless.$rule_name.encryption="psk2"
set wireless.$rule_name.mesh_id=$ssid
EOI
uci commit
