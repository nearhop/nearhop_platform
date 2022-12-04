#!/bin/sh
rootgw=$1

res=`wget -q -O - http://$rootgw:11000/isonboardingopen`
echo $res
