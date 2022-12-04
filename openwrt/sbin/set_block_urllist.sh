#!/bin/sh
while [[ $# -gt 0 ]]; do
	/sbin/uci set nearhop.@router[0].block$1=$2
	shift
	shift
done
/sbin/uci commit nearhop
/etc/init.d/blocklist restart &
