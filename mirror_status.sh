#!/bin/sh
mirrorha_status=`mirrorha status |grep running`
if [ "$mirrorha_status" != "" ];then
   echo started
   exit 0
fi
   echo stopped
   exit 0
