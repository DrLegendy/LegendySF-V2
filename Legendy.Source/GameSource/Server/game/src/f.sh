#!/bin/sh
echo "write something:"
# read smtg
smth=$1
grep "$smth" *.h *.cpp ../../common/*.h

