#!/bin/sh
while [[ $# -gt 0 ]]; do
	case $1 in
	--config)
		config="$2"
		;;
	--name)
		name="$2"
		;;
	esac
	shift
	shift
done
. /sbin/nh_common.sh
ssid2=`/sbin/uci_get.sh "/sbin/uci get wireless.$HOME2.ssid"`
echo "ssid2="$ssid2
disabled2=`/sbin/uci_get.sh "/sbin/uci get wireless.$HOME2.disabled"`
echo "disabled2="$disabled2
gssid2=`/sbin/uci_get.sh "/sbin/uci get wireless.$GUEST2.ssid"`
echo "gssid2="$gssid2
gdisabled2=`/sbin/uci_get.sh "/sbin/uci get wireless.$GUEST2.disabled"`
echo "gdisabled2="$gdisabled2
encryption=`/sbin/uci_get.sh "/sbin/uci get wireless.$HOME2.encryption"`
echo "encryption="$encryption
gencryption=`/sbin/uci_get.sh "/sbin/uci get wireless.$GUEST2.encryption"`
echo "gencryption="$gencryption
key2=`/sbin/uci_get.sh "/sbin/uci get wireless.$HOME2.key"`
echo "key2="$key2
gkey2=`/sbin/uci_get.sh "/sbin/uci get wireless.$GUEST2.key"`
echo "gkey2="$gkey2
ssid5=`/sbin/uci_get.sh "/sbin/uci get wireless.$HOME51.ssid"`
echo "ssid5="$ssid5
disabled5=`/sbin/uci_get.sh "/sbin/uci get wireless.$HOME51.disabled"`
echo "disabled5="$disabled5
gssid5=`/sbin/uci_get.sh "/sbin/uci get wireless.$GUEST51.ssid"`
echo "gssid5="$gssid5
gdisabled5=`/sbin/uci_get.sh "/sbin/uci get wireless.$GUEST51.disabled"`
echo "gdisabled5="$gdisabled5
key5=`/sbin/uci_get.sh "/sbin/uci get wireless.$HOME51.key"`
echo "key5="$key5
gkey5=`/sbin/uci_get.sh "/sbin/uci get wireless.$GUEST51.key"`
echo "gkey5="$gkey5
ssid52=`/sbin/uci_get.sh "/sbin/uci get wireless.$HOME52.ssid"`
echo "ssid52="$ssid52
disabled52=`/sbin/uci_get.sh "/sbin/uci get wireless.$HOME52.disabled"`
echo "disabled52="$disabled52
gssid52=`/sbin/uci_get.sh "/sbin/uci get wireless.$GUEST52.ssid"`
echo "gssid52="$gssid52
gdisabled52=`/sbin/uci_get.sh "/sbin/uci get wireless.$GUEST52.disabled"`
echo "gdisabled52="$gdisabled52
key52=`/sbin/uci_get.sh "/sbin/uci get wireless.$HOME52.key"`
echo "key52="$key52
gkey52=`/sbin/uci_get.sh "/sbin/uci get wireless.$GUEST52.key"`
echo "gkey52="$gkey52
chan2=`/sbin/uci_get.sh "/sbin/uci get wireless.$RADIO2.channel"`
echo "chan2="$chan2
chanwidth2=`/sbin/uci_get.sh "/sbin/uci get wireless.$RADIO2.htmode"`
echo "chanwidth2="$chanwidth2
chan5=`/sbin/uci_get.sh "/sbin/uci get wireless.$RADIO51.channel"`
echo "chan51="$chan5
chanwidth5=`/sbin/uci_get.sh "/sbin/uci get wireless.$RADIO51.htmode"`
echo "chanwidth51="$chanwidth5
chan52=`/sbin/uci_get.sh "/sbin/uci get wireless.$RADIO52.channel"`
echo "chan52="$chan52
chanwidth52=`/sbin/uci_get.sh "/sbin/uci get wireless.$RADIO52.htmode"`
echo "chanwidth52="$chanwidth52
meshid=`/sbin/uci_get.sh "/sbin/uci get wireless.$MESHIF.mesh_id"`
echo "meshid="$meshid
meshkey=`/sbin/uci_get.sh "/sbin/uci get wireless.$MESHIF.key"`
echo "meshkey="$meshkey
fwversion=`cat /etc/openwrt_release  | grep DISTRIB_RELEASE | awk 'BEGIN { FS = "=" } {print $2}' | awk -F\' '{print $2}'`
echo "fwversion="$fwversion
uptime=`cat /proc/uptime  | awk '{print $1}' | awk 'BEGIN {FS = "." } {print $1}'`
echo "uptime="$uptime
model=`cat /tmp/sysinfo/board_name  | awk 'BEGIN{FS=","} {print $2}'`
echo "model="$model
if [ -f /tmp/update_repeater ]; then
	echo "fwupdate=1"
else
	echo "fwupdate=0"
fi
