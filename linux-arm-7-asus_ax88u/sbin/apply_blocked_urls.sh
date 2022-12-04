#!/bin/sh

rm /tmp/dnsmasq.d/blocklist.txt
function add_to_bloclist ()
{
	/usr/bin/awk '{printf("address=/%s/\n", $1);}' $1 >> /tmp/dnsmasq.d/blocklist.txt
}

for fullfile in /jffs/nearhop/etc/blocklists/*.txt; do
	filename=$(basename -- "$fullfile")
	filename="${filename%.*}"
	blocked=`grep -i "block$filename=1" /jffs/nearhop/router_configs/blocklist.txt | grep -v grep | wc | awk '{print $1}'`
	if [ 0$blocked -eq 1 ]; then
		echo "Adding $filename urls to blocklist"
		add_to_bloclist $fullfile
	fi
done
