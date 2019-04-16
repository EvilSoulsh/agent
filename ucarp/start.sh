#!/bin/bash
BASE_DIR=`dirname $0`
MASTER_UCARP="/etc/master.sh"
SLAVE_UCARP="/etc/slave.sh"
SEND_EVENT="$BASE_DIR/sendAlarm.sh"
RETVAL=0
jboss() {
jboss=`ps aux | grep jboss | grep Main | sed 's/[ ][ ]*/=/g' | cut -d '=' -f 2`
if [ "$jboss" == "" ];then
      service jboss start
jboss=`ps aux | grep jboss | grep Main | sed 's/[ ][ ]*/=/g' | cut -d '=' -f 2`
      if [ "$jboss" == "" ];then
            
	 echo "start tomcat failed"
         exit 1
      fi
    
     echo "jboss start --------OK"
fi
}
ha() {
echo -n $"Starting ucarp service: "

           	if [ -f $MASTER_UCARP ] ; then 
echo $MASTER_UCARP                 
 $MASTER_UCARP
 $SEND_EVENT "<?xml version=\"1.0\" encoding=\"UTF-8\"?><message><MessageType>event</MessageType><EntityInstance>jboss</EntityInstance><ProbableCause>jboss ucarp start</ProbableCause><Message>jboss ucarp is running as master</Message></message>"
else 
echo $SLAVE_UCARP
$SLAVE_UCARP
 $SEND_EVENT "<?xml version=\"1.0\" encoding=\"UTF-8\"?><message><MessageType>event</MessageType><EntityInstance>jboss</EntityInstance><ProbableCause>jboss ucarp start</ProbableCause><Message>jboss ucarp is running as slave</Message></message>"
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




