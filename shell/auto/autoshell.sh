#!/usr/bin/expect
set timeout -1
spawn ssh root@192.168.151.100
expect "*password:"
send "pass\r"
expect "*#"
send "ifconfig | grep 'inet addr' | grep -v '127.0.0.1'\r"
send "exit\r"
expect eof
#interact