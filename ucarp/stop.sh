#!/bin/bash
BASE_DIR=`dirname $0`
RETVAL=0
RETMSG="success"
SEND_EVENT="$BASE_DIR/sendAlarm.sh"
UCARP_DOWN="/etc/vip-down.sh"
#echo "$1"
jboss() {
    jboss=`ps aux | grep jboss | grep Main | sed 's/[ ][ ]*/=/g' | cut -d '=' -f 2`
    if [ "$jboss" != "" ];then
      kill -15 $jboss
    fi 
    num=0
    while [  $num -lt 5 ]
    do
      sleep 1s
      let "num=$num + 1"
      jboss=`ps aux | grep jboss | grep Main | sed 's/[ ][ ]*/=/g' | cut -d '=' -f 2`
      if [ "$jboss" == "" ];then
       num=6
      fi
    done
    if [ "$jboss" != "" ];then
    # echo "tomcat = $tomcat"
      kill -9 $jboss
    fi


}
ha() {
echo -n $"Shutting down ucarp service: "
		if [ -f $UCARP_DOWN ]; then
			$UCARP_DOWN
		fi
		ps aux | grep /usr/local/sbin/ucarp | grep /etc/vip-up.sh |awk '{print "kill -9 " $2}' |sh
		RETVAL=$?
            		if [ $RETVAL -eq 0 ];then
               $SEND_EVENT "<?xml version=\"1.0\" encoding=\"UTF-8\"?><message><MessageType>event</MessageType><EntityInstance>jboss</EntityInstance><ProbableCause>jboss ucarp stop</ProbableCause><Message>jboss ucarp stopped</Message></message>"
fi	
	return $RETVAL
}

case "$1" in
    jboss)
      jboss
     ;;
    ha)
      ha  
    ;;

    *)
     jboss
     ha
esac 
exit 0




