#!/bin/bash
#192.168.0.1 80
#192.168.0.1 8080
cat $1 | while read line
do
	nc  -z -v -w1 $line >/dev/null 2>&1
	if [ $? -eq 0 ]
	then
		echo $line:ok
	else
		echo $line:fail
	fi
done
