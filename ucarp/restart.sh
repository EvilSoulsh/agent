#!/bin/bash

BASE_DIR=`dirname $0`




#echo "$1"

case "$1" in
    ha)
    $BASE_DIR/stop.sh ha
    $BASE_DIR/start.sh ha  
    ;;

esac 
exit 0




