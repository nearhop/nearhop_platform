#!/bin/sh

while true
do
	npid=`ps | grep "nearhopd" | grep -v grep | awk '{print $1}'`
	if [ "$npid" == "" ]; then
		/jffs/nearhop/usr/sbin/nearhopd &
		sleep 10
	fi	
	sleep 10
done
