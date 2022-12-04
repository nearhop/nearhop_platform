#!/bin/sh
if [ -f /sbin/nh_common.sh ]; then
	. /sbin/nh_common.sh
fi
if [ -f /jffs/nearhop/sbin/nh_common.sh ]; then
	. /jffs/nearhop/sbin/nh_common.sh
fi

base_url="https://nearhop.sfo3.digitaloceanspaces.com/blockedurls"
cur=`cat $NH_FILESYSTEM_BASE/etc/blockedurlsversion.txt`

if [ -f /tmp/update_blocked_url_running ]; then
	exit 0
fi
touch /tmp/update_blocked_url_running

while true
do
	wget -q $base_url/latest.txt -O /tmp/blockedlatest.txt
	latest=`cat /tmp/blockedlatest.txt`

	if [ "$latest" == "" ]; then
		echo "Not able to get blocked url's latest version"
		sleep 10
		continue
	fi

	if [ "$cur" == "$latest" ]; then
		echo "You have Latest blocked url lst"
		rm /tmp/update_blocked_url_running
		exit 0
	fi
	wget $base_url/$latest/blocklists.tar.gz -O /tmp/blocklists.tar.gz
	wget -q $base_url/$latest/blockedmd5.txt -O /tmp/blockedlatest_md5.txt
	blockedlatest_md5=`cat /tmp/blockedlatest_md5.txt`
	computed=`md5sum /tmp/blocklists.tar.gz | awk '{print $1}'`
	if [ "$computed" != "$blockedlatest_md5" ]; then
		echo "URL block list download failure"
		sleep 10
		continue
	fi
	mkdir -p $NH_FILESYSTEM_BASE/etc
	tar -zxvf /tmp/blocklists.tar.gz -C $NH_FILESYSTEM_BASE/etc
	if [ $? == 0 ]; then
		echo $latest > $NH_FILESYSTEM_BASE/etc/blockedurlsversion.txt
	fi
	echo "Updated url blocklist"
	$NH_FILESYSTEM_BASE/sbin/apply_dns.sh
	rm /tmp/update_blocked_url_running
	exit 0
done
