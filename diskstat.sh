#!/bin/sh
#name:disk
#function:fetch disk statistic data

sar -pd 15 1 |sed -n '/Average/p'
exit 0
