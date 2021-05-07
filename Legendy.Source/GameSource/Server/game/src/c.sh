#!/bin/sh
# gmake clean default >syslog 2>syserr
# v_date=`date +%Y%m%d-%H%M%S`
# gmake clean default 2>.nope.log_${v_date}.txt
# gmake CC=clang
gmake clean dep default 2>.nope.log.txt
