#/bin/sh
for ip in `cat ip.txt`;do
	#etg: ip user passwood cmd
	./expect_util.sh $ip "root" "1qaz@WSX" "ifconfig | grep 'inet addr' | grep -v '127.0.0.1'"
done
