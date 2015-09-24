#!/bin/bash
if [ ${#} -eq 0 ]; then
	msg "not enough arguments"
	exit 1
fi
VAR=$1
if [ "x${VAR%%[^0-9]*}" =  "x$VAR" ]; then
	echo "$VAR is number"
else
	echo "$VAR is not number"
fi
exit 0
