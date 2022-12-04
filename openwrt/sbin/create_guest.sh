#!/bin/sh

function create_guest()
{
	radio=$1
	rule_name="guest_"$radio
	exists=`/sbin/uci get wireless.$rule_name.network`
	if [ "$exists" != "" ]; then
		return
	fi	
uci batch << EOI
set wireless.$rule_name=wifi-iface
set wireless.$rule_name.device=$radio
set wireless.$rule_name.network="lan"
set wireless.$rule_name.mode="ap"
set wireless.$rule_name.disabled="1"
set wireless.$rule_name.key="nguest1234"
set wireless.$rule_name.encryption="psk2"
set wireless.$rule_name.ssid="NearGuest"
EOI
uci commit
}
. /sbin/nh_common.sh

create_guest $RADIO2
create_guest $RADIO51
