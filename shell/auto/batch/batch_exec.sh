#!/usr/bin/expect
set timeout -1
spawn ssh root@192.168.151.93
expect "*password:"
send "pass\r"
expect "*#"
send "/export/servers/showip.sh\r"
send "exit\r"
expect eof
