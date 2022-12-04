#!/bin/sh
rm /jffs/nearhop/router_configs/blocklist.txt 
while [[ $# -gt 0 ]]; do
	echo block$1=$2 >> /jffs/nearhop/router_configs/blocklist.txt
	shift
	shift
done
/jffs/nearhop/sbin/apply_dns.sh
