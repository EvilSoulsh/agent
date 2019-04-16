#!/bin/sh
filenum=`ls -l /opt/fonsview/etc/db/db_cfg_*.xml|wc -l`
if [ "$filenum" == "1" ]; then
	haFlag=`cat /opt/fonsview/etc/db/db_cfg_*.xml|grep "<haFlag>1<\/haFlag>"`
	if [ "$haFlag" != "" ];then
	#has ha
		vip=`cat /opt/fonsview/etc/db/db_cfg_*.xml|grep virtualIp`
		ipaddress_1=`echo $vip |sed 's/<virtualIp>//g'`
		ipaddress=`echo $ipaddress_1|sed 's/<\/virtualIp>//g'`
		ha_status=`ifconfig |grep $ipaddress`
		if [ "$ha_status" != "" ];then
			echo active
			exit 0
		fi
			echo standby
			exit 0
	else
	#not has ha
	echo no found db cfg file
	exit 0
	fi  
else
   echo no found db cfg file
   exit 1
fi

