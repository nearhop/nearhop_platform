#!/bin/sh
mac=$1
cat /var/lib/misc/dnsmasq.leases  | grep -i "$mac" | awk '{print $4}'
