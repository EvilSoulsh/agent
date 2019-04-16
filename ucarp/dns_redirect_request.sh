#!/bin/bash

num=`cat /opt/fonsview/NE/drs/proc/dns_statis |grep "DNS_REQ_SPEED"|cut -d":" -f 2`
echo ${num}
