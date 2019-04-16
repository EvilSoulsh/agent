
RETVAL=0
RETMSG="success"
DIR_ETC="/opt/fonsview/NE/agent/script/syslog/"
FILTER_SYSCONFIG="agent_syslog_"
syslogconfig="/etc/rsyslog.conf"
CONFIG="$DIR_ETC/syslogconfig"
CONFIG_CHECK="/opt/fonsview/NE/agent/script/syslog/config_check.sh"
fac=(kern user mail daemon auth syslog lpr news uucp cron authpriv ftp ntp logaudit logalert cron2 local0 local1 local2 local3 local4 local5 local6 local7)
level=(emerg alert crit err warning notice info debug)

reload_file() {
logDirPath="/var/log/fonsview"
if [ ! -d "$logDirPath" ]; then  
mkdir "$logDirPath"  
fi  
	if [ $1"x" != "x" ] ; then
		new_xml=`ls -t $DIR_ETC |grep $FILTER_SYSCONFIG |grep -v $1|awk 'NR==1'`
       
else 
       new_xml=`ls -t $DIR_ETC |grep $FILTER_SYSCONFIG |awk 'NR==1'`
fi
		if [ $new_xml"x" == "x" ] ;then 
			RETVAL=1
			RETMSG="file is not exist!"
			return $RETVAL
		fi
			echo " $DIR_ETC$new_xml"
                        if [ -f $CONFIG ] ; then
                        	rm -rf  $CONFIG
                        fi
                        touch $CONFIG
                        echo  "$new_xml" >> $CONFIG
			config_value=$( awk '/<filter>/ {stp=index($0,">")+1;  newstr=substr($0,stp); etp=index(newstr,"<")-1;  print substr(newstr,0,etp);  }' $DIR_ETC$new_xml)
			syslogserver=$( awk '/<ipAddress>/ {stp=index($0,">")+1;  newstr=substr($0,stp); etp=index(newstr,"<")-1;  print substr(newstr,0,etp);  }' $DIR_ETC$new_xml)
	for((i=0;i<24;i++)); do
	for((j=0;j<8;j++)); do
		k=$[$i*8+$j]
   	if [ ${config_value:k:1}"x" == "1x" ] ;then
  sed -i "/${fac[i]}.${level[j]}/d" $syslogconfig
server_ip=`ifconfig | grep -A 1 ${syslogserver} | grep 'inet addr:' | sed 's/.*inet addr://g' | sed 's/[[:blank:]]*Bcast.*//g'`
#echo $server_ip
#sub_str=""
#for((a=j-1;a>-1;a--));do
##sts = "${level[a]}.none"
#sub_str="$sub_str;${level[a]}.none"
#done
#echo $sub_str
#echo $server_ip
if [ $server_ip"x" != "x" ];then
logFile="/var/log/fonsview/${fac[i]}.${level[j]}"
if [ ! -f "$logFile" ]; then   
touch "$logFile"  
fi
echo "${fac[i]}.${level[j]}	/var/log/fonsview/${fac[i]}.${level[j]}" >> $syslogconfig
else
echo "${fac[i]}.${level[j]}	@$syslogserver:514" >> $syslogconfig
fi
# if [ -z "`grep "${fac[i]}.${level[j]} @ $syslogserver   /var/log/fonsview/${fac[i]}.${level[j]}.log" $syslogconfig`" ]     ;then
 #   	echo "${fac[i]}.${level[j]} @ $syslogserver   /var/log/fonsview/${fac[i]}.${level[j]}.log" >> $syslogconfig
  #  	fi
    	fi
    	
    	  if	 [ ${config_value:k:1}"x" == "0x" ] ;then
    	sed -i "/${fac[i]}.${level[j]}/d" $syslogconfig
    
    	fi
    	done
    		done 
   	if [ $RETVAL -eq 0 ] ;then
   			  systemctl restart rsyslog.service
        fi			
		RETVAL=$?
		[ $RETVAL -ne 0 ] && RETMSG="failure"
	
	return $RETVAL
}



case "$1" in
  reload_file)
        current=`$CONFIG_CHECK`
  	echo "$current"
        reload_file $current 
	;;
   *)
	echo $"Usage: $0 {reeload_file}"
	RETMSG="failure"
	RETVAL=1
esac

echo $RETMSG
exit $RETVAL
