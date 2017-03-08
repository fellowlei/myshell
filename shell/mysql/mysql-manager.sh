#!/bin/sh

case "$1" in
start)
echo -n "starting mysqld "
/usr/bin/mysqld_safe --user=mysql &
;;
stop)
echo -n "shutting down mysqld "
/usr/bin/mysqladmin -uroot -p shutdown
;;
status)
echo -n "check for mysqld "
count=`ps aux| grep mysqld | grep -v grep | wc -l`
if [ "$count" -ge 1 ]; then
        echo "ok"
else
        echo "not exists!"
fi
;;
*)
echo "Usage: $0 {start:stop:status}"
exit 1
esac
