#!/bin/sh
board=`cat /tmp/sysinfo/board_name`

if [ -f /tmp/fwupdateinprogress ]; then
	exit 0
fi
touch /tmp/fwupdateinprogress

boardname=""
case "$board" in
glinet,gl-b1300)
	boardname="gl-b1300"
	;;
esac
if [ "$boardname" == "" ]; then
	echo "Board not supported yet"
	rm /tmp/fwupdateinprogress
	exit 0
fi

base_url="https://nearhop.sfo3.digitaloceanspaces.com/router/openwrt/$boardname"
cur=`cat /etc/openwrt_release  | grep DISTRIB_RELEASE | awk 'BEGIN { FS = "=" } {print $2}'`

cur=`echo $cur | sed "s/'//g"`
latest=""
while true
do
	wget -q $base_url/nearhopversion.txt -O /tmp/nearhopversion.txt
	if [ $? -ne 0 ]; then
		sleep 10
		continue
	fi
	latest=`cat /tmp/nearhopversion.txt`

	if [ "$latest" == "" ]; then
		logger "No latest firmware. Tryi again"
		sleep 10
		continue
	fi
	break
done
echo "cur..."$cur
echo "latest..."$latest

if [ "$cur" == "$latest" ]; then
	# We already have latest version
	# Probably repeater
	touch /tmp/update_repeater
	echo "You have Latest Firmware"
	rm /tmp/fwupdateinprogress
	exit 0
fi

while true
do
	wget $base_url/$latest/firmware.bin -O /tmp/firmware.bin
	if [ $? -ne 0 ]; then
		logger "Error while downloading the firmware. Try again"
		sleep 15
		continue
	fi
	wget -q $base_url/$latest/nearhop.md5 -O /tmp/latest_md5.txt
	if [ $? -ne 0 ]; then
		logger "Error while downloading firmware md5. Try again"
		sleep 15
		continue
	fi
	latest_md5=`cat /tmp/latest_md5.txt`
	computed=`md5sum /tmp/firmware.bin | awk '{print $1}'`
	if [ "$computed" != "$latest_md5" ]; then
		logger "Download Failure. Try again"
		sleep 15
		continue
	fi
	echo "Firmware upgrade command issued. Upgrading Firmware"
	break
done
/sbin/sysupgrade /tmp/firmware.bin
rm /tmp/fwupdateinprogress
