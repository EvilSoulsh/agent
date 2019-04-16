#sh sendAlarm.sh '<?xml version="1.0" encoding="UTF-8"?><message><MessageType>event</MessageType><EntityInstance>epg</EntityInstance><ProbableCause>appStartsssssssssssssssss</ProbableCause><Message>tvld running</Message></message>'

exec 3<>/dev/udp/127.0.0.1/8004
echo -n $1 >&3
exec 3>&-
