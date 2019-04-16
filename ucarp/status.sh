#!/bin/bash
RETVAL=0
RETMSG="success"
SEND_EVENT="./sendAlarm.sh"
MASTER_UCARP="/etc/master.sh"
SLAVE_UCARP="/etc/slave.sh"
#echo "$1"
haservice() {
    haService=`ps aux | grep /usr/local/sbin/ucarp | grep /etc/vip-up.sh`
    if [ "$haService" != "" ];then
     echo "started"
else
echo "stopped"
    fi 


}
hastatus() {

 haStatus=`ps aux | grep /usr/local/sbin/ucarp  | grep /etc/vip-up.sh`
    if [ "$haStatus" != "" ];then
     haS=`ps aux | grep /usr/local/sbin/ucarp  | grep /etc/vip-up.sh | grep hello123 |grep k`
	if [ "$haS" != "" ];then
		if [ -f $SLAVE_UCARP ] ; then
			echo "standby"
		else 
			echo "active"
		fi
	else 
		echo "active"
	fi
     else
	if [ -f $MASTER_UCARP ] ; then
		echo "active"
	elif [ -f $SLAVE_UCARP ]; then
		echo "standby"
	else
		echo "N/A"

	fi
    fi

}

case "$1" in
    haservice)
      haservice
     ;;
    ha)
      hastatus  
    ;;

esac 
exit 0




