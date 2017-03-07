#!/bin/sh
#eg: showpath.sh nginx
if [ $# -ne 1 ]; then
  echo "must input name"
  exit 1
fi

for pid in `ps -ef | grep $1 | grep -v grep | grep -v showpath | awk '{print $2}'`;
do
	echo -n "${pid} "
	ls -l /proc/${pid}/exe | awk '{print $11}'
done
