#!/bin/sh
insmod /lib/modules/4.1.51/kernel/drivers/net/tun.ko
mkdir -p /jffs/nearhop/router_configs/
mkdir -p /tmp/dnsmasq.d
killall -9 nearhopd
killall unum
killall monitor_nearhop.sh
/jffs/nearhop/usr/sbin/nearhopd &
/jffs/nearhop/usr/bin/unum &
/jffs/nearhop/sbin/monitor_nearhop.sh &
