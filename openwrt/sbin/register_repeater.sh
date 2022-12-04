#!/bin/sh
op_mode=`/sbin/uci get nearhop.@unum[0].opmode`
if [ "$op_mode" != "ap" ]; then
	exit 0
fi
. /sbin/nh_common.sh

counter=0
fwver=`cat /etc/openwrt_release  | grep DISTRIB_RELEASE | awk 'BEGIN { FS = "=" } {print $2}'`

fwver=`echo $fwver | sed "s/'//g"`
while true
do
	sleep 20
	rootgw=`/sbin/get_rootip.sh`
	if [ $rootgw == "" ]; then
		continue
	fi
	status=`/usr/sbin/nearhopd-cli -ipaddress $rootgw -command register_repeater -iname $BRIDGENAME -miname $MESHIFNETWORKNAME -fwver $fwver`
	if [ "$status" == "{\"status\":\"success\"}" ]; then
		break
	fi
	counter=`expr $counter + 1`
	if [ $counter -gt 20 ]; then
		logger "Not able to register even after multiple retries.."$BRIDGENAME" "$MESHIFNETWORKNAME
		break
	fi
done
