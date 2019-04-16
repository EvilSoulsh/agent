#!/bin/bash

CONFIG="/opt/fonsview/NE/agent/script/syslog/syslogconfig"
	if [ -f $CONFIG ] ; then	
		RETMSG=`cat $CONFIG |awk 'NR==1'`
echo -n $RETMSG
	fi		
exit 0
