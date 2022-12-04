#!/bin/sh
nvram set MULTIFILTER_ALL=1
nvram commit

mac=$1
ip=$2
pause=$3
name=$4
macstring=""
macstring=`nvram get MULTIFILTER_MAC | awk -v var="$mac" 'BEGIN{FS=">";} {for(i=1; i <= NF; i++) if (var == $i) {continue;} else {if (i == 1) {printf("%s", $i);} else {printf(">%s", $i);}}}'`
namestring=`nvram get MULTIFILTER_DEVICENAME | awk -v var="$mac" 'BEGIN{FS=">";} {for(i=1; i <= NF; i++) if (var == $i) {continue;} else {if (i == 1) {printf("%s", $i);} else {printf(">%s", $i);}}}'`
num_of_macs=`nvram get MULTIFILTER_MAC | awk -v var="$mac" 'BEGIN{FS=">";} {counter=0; for(i=1; i <= NF; i++) if (var == $i) {continue;} else {counter++}}; {print counter}'`
if [ 0$pause -eq 1 ]; then
	if [ 0$num_of_macs -gt 0 ]; then
		macstring="$macstring>$mac"
		namestring="$namestring>$name"
		num_of_macs=`expr $num_of_macs + 1`
	else
		macstring="$mac"
		namestring="$name"
		num_of_macs=1
	fi
fi

echo "namestring.."$namestring
echo "name.."$name
echo $macstring
echo $namestring
echo $num_of_macs
ind=1
filterstring="2"
while [ $ind -lt $num_of_macs ]
do
	filterstring="$filterstring>2"
	ind=`expr $ind + 1`
	
done 
nvram set MULTIFILTER_MAC=$macstring
nvram set MULTIFILTER_DEVICENAME="$macstring"
nvram set MULTIFILTER_ENABLE="$filterstring"
nvram commit
rc rc_service restart_firewall
