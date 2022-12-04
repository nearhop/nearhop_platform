#!/bin/sh
while [[ $# -gt 0 ]]; do
	case $1 in
	--ssid2)
		ssid2="$2"
		;;
	--key2)
		key2="$2"
		;;
	--ssid5)
		ssid5="$2"
		;;
	--key5)
		key5="$2"
		;;
	--gssid2)
		gssid2="$2"
		;;
	--gkey2)
		gkey2="$2"
		;;
	--gssid5)
		gssid5="$2"
		;;
	--gkey5)
		gkey5="$2"
		;;
	--chan2)
		chan2="$2"
		;;
	--chan51)
		chan51="$2"
		;;
	--chan52)
		chan52="$2"
		;;
	--chan6)
		chan6="$2"
		;;
	--chanwidth2)
		chanwidth2="$2"
		;;
	--chanwidth51)
		chanwidth51="$2"
		;;
	--chanwidth52)
		chanwidth52="$2"
		;;
	--chanwidth6)
		chanwidth6="$2"
		;;
	--encryption)
		encryption="$2"
		;;
	--gencryption)
		gencryption="$2"
		;;
	--disabled2)
		disabled2="$2"
		;;
	--disabled5)
		disabled5="$2"
		;;
	--disabled52)
		disabled52="$2"
		;;
	--meshssid)
		meshssid="$2"
		;;
	--meshkey)
		meshkey="$2"
		;;
	esac
	shift
	shift
done
. /sbin/nh_common.sh
/sbin/uci batch << EOI
set wireless.$HOME2.ssid="$ssid2"
set wireless.$HOME2.key="$key2"
set wireless.$HOME51.ssid="$ssid5"
set wireless.$HOME51.key="$key5"
set wireless.$HOME52.ssid="$ssid52"
set wireless.$HOME52.key="$key52"
set wireless.$GUEST2.ssid="$gssid2"
set wireless.$GUEST2.key="$gkey2"
set wireless.$GUEST51.ssid="$gssid5"
set wireless.$GUEST51.key="$gkey5"
set wireless.$GUEST52.ssid="$gssid52"
set wireless.$GUEST52.key="$gkey52"
set wireless.$HOME2.disabled="$disabled2"
set wireless.$HOME51.disabled="$disabled5"
set wireless.$HOME52.disabled="$disabled52"
EOI
/sbin/uci commit

emeshid=`/sbin/uci get wireless.$MESHIF.mesh_id`
emeshkey=`/sbin/uci get wireless.$MESHIF.key`
if [ "$emeshid" == "" ] || [ "$emeshid" != "$meshid" ]; then
	/sbin/uci set wireless.$MESHIF.mesh_id="$meshssid"
fi
if [ "$emeshkey" == "" ] || [ "$emeshkey" != "$meshkey" ]; then
	/sbin/uci set wireless.$MESHIF.key="$meshkey"
fi
/sbin/uci commit
/sbin/wifi up &
