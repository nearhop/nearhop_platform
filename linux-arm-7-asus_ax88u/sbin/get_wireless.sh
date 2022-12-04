#!/bin/sh
ssid2=`/bin/nvram get wl0_ssid`
echo "ssid2="$ssid2
enabled2=`/bin/nvram get wl0_bss_enabled`
if [ 0$enabled2 -eq 1 ]; then
	echo "disabled2=0"
else
	echo "disabled2=1"
fi
gssid2=`/bin/nvram get wl0.1_ssid`
echo "gssid2="$gssid2
genabled2=`/bin/nvram get wl0_bss_enabled`
if [ 0$genabled2 -eq 1 ]; then
	echo "gdisabled2=0"
else
	echo "gdisabled2=1"
fi
encryption=`/bin/nvram get wl0_auth_mode_x`
echo "encryption="$encryption
gencryption=`/bin/nvram get wl0.1_auth_mode_x`
echo "gencryption="$gencryption
key2=`/bin/nvram get wl0_wpa_psk`
echo "key2="$key2
gkey2=`/bin/nvram get wl0.1_wpa_psk`
echo "gkey2="$gkey2

ssid5=`/bin/nvram get wl1_ssid`
echo "ssid5="$ssid5
enabled5=`/bin/nvram get wl1_bss_enabled`
if [ 0$enabled5 -eq 1 ]; then
	echo "disabled5=0"
else
	echo "disabled5=1"
fi
gssid5=`/bin/nvram get wl1.1_ssid`
echo "gssid5="$gssid5
genabled5=`/bin/nvram get wl1_bss_enabled`
if [ 0$genabled5 -eq 1 ]; then
	echo "gdisabled5=0"
else
	echo "gdisabled5=1"
fi
key5=`/bin/nvram get wl1_wpa_psk`
echo "key5="$key5
gkey5=`/bin/nvram get wl1.1_wpa_psk`
echo "gkey5="$gkey5

chan2=`/bin/nvram get wl0_chanspec | awk 'BEGIN{FS="/"}{print $1}'`
echo "chan2="$chan2
chanwidth2=`/bin/nvram get wl0_chanspec | awk 'BEGIN{FS="/"}{print $2}'`
echo "chanwidth2="$chanwidth2
chan5=`/bin/nvram get wl1_chanspec | awk 'BEGIN{FS="/"}{print $1}'`
echo "chan5="$chan5
chanwidth5=`/bin/nvram get wl1_chanspec | awk 'BEGIN{FS="/"}{print $2}'`
echo "chanwidth5="$chanwidth5
fwversion=`cat /jffs/nearhop/nearhopversion.txt`
echo "fwversion="$fwversion
uptime=`cat /proc/uptime  | awk '{print $1}' | awk 'BEGIN {FS = "." } {print $1}'`
echo "uptime="$uptime
model=`nvram get model | awk 'BEGIN{FS="-"} {print $2}'`
echo "model="$model
