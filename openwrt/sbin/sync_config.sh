#!/bin/sh
dontwait=$1
op_mode=`/sbin/uci get nearhop.@unum[0].opmode`
if [ "$op_mode" != "ap" ] && [ 0$dontwait -ne 1 ]; then
	exit 0
fi

while true
do
	if [ 0$dontwait -ne 1 ]; then
		sleep 60
	fi
	rootgw=`/sbin/get_rootip.sh`
	if [ "$rootgw" == "" ]; then
		logger "Error while getting the Root gw "$error
		echo "Error while getting the Root gw "$error
		if [ 0$dontwait -ne 1 ]; then
			continue
		fi
		break
	fi
	changed=`/usr/sbin/nearhopd-cli -ipaddress $rootgw -command check_wireless`
	if [ "$changed" == "UpdateFirmware" ]; then
		logger "Firmware update triggered from root (or from app indeed)"
		/sbin/fw_update.sh
	fi
	if [ "$changed" != "Changed" ]; then
		if [ 0$dontwait -ne 1 ]; then
			continue
		fi
		break
	fi
	settings=`/usr/sbin/nearhopd-cli -ipaddress $rootgw -command get_wireless`
	error=`echo $settings | grep ^Error`
	if [ "$error" != "" ]; then
		logger "Error while getting the settings from the root."$error
		echo "Error while getting the settings from the root."$error
		if [ 0$dontwait -ne 1 ]; then
			continue
		fi
		break
	fi
	echo $settings > /tmp/settings.txt
	error=`/usr/sbin/nearhopd-cli -ipaddress 127.0.0.1 -command set_wireless -data /tmp/settings.txt`
	if [ "$error" != "" ]; then
		logger "Error while getting the settings from the root."$error
		echo "Error while getting the settings from the root."$error
		if [ 0$dontwait -ne 1 ]; then
			continue
		fi
		break
	fi
	if [ 0$dontwait -eq 1 ]; then
		break
	fi
done
