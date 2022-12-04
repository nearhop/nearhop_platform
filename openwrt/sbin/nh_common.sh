#!/bin/sh
board=`cat /tmp/sysinfo/board_name`
function get_home_section()
{
	radio="$1"
	index="$2"
	i=0

	while true
	do
		mode=`/sbin/uci get wireless.@wifi-iface[$i].mode`
		if [ "$mode" == "ap" ]; then
			r=`/sbin/uci get wireless.@wifi-iface[$i].device`
			if [ "$r" == "$radio" ]; then
				index=`expr $index - 1`
			fi
			if [ $index == 0 ]; then
				echo "@wifi-iface[$i]"
				break
			fi
		fi
		i=`expr $i + 1`
		if [ $i -gt 10 ]; then
			break
		fi
	done	
}

case "$board" in
	glinet,gl-b1300)
	export RADIO2="radio0"
	export RADIO51="radio1"
	h2=$(get_home_section $RADIO2 1)
	h5=$(get_home_section $RADIO51 1)
	export HOME2=$h2
	export HOME51=$h5
	g2=$(get_home_section $RADIO2 2)
	g5=$(get_home_section $RADIO51 2)
	mac1=`cat /sys/class/net/eth0/address`
	export GUEST2=$g2
	export GUEST51=$g5
	export HOME52="na"
	export HOME6="na"
	export NUM_OF_RADIOS=2
	export MAC=$mac1
	export MESHRADIO=$RADIO51
	export MESHIF="mesh"
	export MESHIFNETWORKNAME="wlan1"
	export BRIDGENAME="br-lan"
	export NH_FILESYSTEM_BASE="/"
	;;
esac
