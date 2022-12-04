#!/bin/sh
if ! mkdir /tmp/fwupdate.lock 2>/dev/null; then
	exit 0
fi
# Firmware upgrade is two steps here
# In the first step try to upgrade the nearhop files
/jffs/nearhop/sbin/main.sh 0 1
# In the second step try to upgrade the full router firmware
/jffs/nearhop/sbin/main.sh 1 0

sleep 180
/sbin/reboot
