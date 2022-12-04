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
if [ 0$disabled2 -eq 1 ]; then
	enabled2="0"
else
	enabled2="1"
fi
if [ 0$disabled5 -eq 1 ]; then
	enabled5="0"
else
	enabled5="1"
fi
if [ 0$gdisabled2 -eq 1 ]; then
	genabled2="0"
else
	genabled2="1"
fi
if [ 0$gdisabled5 -eq 1 ]; then
	genabled5="0"
else
	genabled5="1"
fi
/bin/nvram set wl0_ssid="$ssid2"
/bin/nvram set wl0_wpa_psk="$key2"
/bin/nvram set wl1_ssid="$ssid5"
/bin/nvram set wl1_wpa_psk="$key5"
/bin/nvram set wl0.1_ssid="$gssid2"
/bin/nvram set wl0.1_wpa_psk="$gkey2"
/bin/nvram set wl1.1_ssid="$gssid5"
/bin/nvram set wl1.1_wpa_psk="$gkey5"
/bin/nvram set wl0_bss_enabled=$enabled2
/bin/nvram set wl1_bss_enabled=$enabled5
/bin/nvram set wl0.1_bss_enabled=$genabled2
/bin/nvram set wl1.1_bss_enabled=$genabled5
/bin/nvram commit

/sbin/restart_wireless &
