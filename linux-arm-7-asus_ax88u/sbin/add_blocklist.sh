#!/bin/sh

rm /tmp/dnsmasq.d/blocklist.txt
function add_to_bloclist ()
{
	/usr/bin/awk '{printf("address=/%s/\n", $1);}' $1 >> /tmp/dnsmasq.d/blocklist.txt
}

for fullfile in /jffs/nearhop/rootfs/etc/blocklists/*.txt; do
	filename=$(basename -- "$fullfile")
	filename="${filename%.*}"
	value=`/sbin/uci get nearhop.@router[0].block$filename`
	value=`/bin/grep "$filename=" /jffs/nearhop/router_configs/blocklist.txt | awk '{print $2}'`
	if [ 0$value -eq 1 ]; then
		logger "Adding $filename urls to blocklist"
		add_to_bloclist $fullfile
	fi
done
logger "Restart dnsmasq after adding blocklists"
killall dnsmasq
