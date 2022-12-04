#!/bin/sh
cp /jffs/nearhop/router_configs/hostnames.txt /tmp/nearhop.hosts
/jffs/nearhop/sbin/apply_blocked_urls.sh
killall dnsmasq
dnsmasq --log-async
