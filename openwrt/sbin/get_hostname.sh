#!/bin/sh
mac=$1
cat /var/dhcp.leases  | grep -i "$mac" | awk '{print $4}'
