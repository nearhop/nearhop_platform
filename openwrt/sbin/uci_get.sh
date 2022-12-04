#!/bin/sh
cmd=$1
val=`$cmd`
if [ "$val" == "" ]; then
	val=`$cmd`
fi
echo $val
