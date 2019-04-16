#!/bin/sh
db_status=`ps -ef |grep mysql |grep mysqld_safe|wc -l`
if [ "$db_status" -gt "1" ]; then
   echo started
   exit 0
else
   echo stopped
   exit 0
fi
