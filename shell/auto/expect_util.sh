#!/usr/bin/expect -f
set timeout -1
set ip [lindex $argv 0]
set user [lindex $argv 1]
set passwd [lindex $argv 2]
set cmd [lindex $argv 3]
spawn ssh $user@$ip
expect "*password:"
send "$passwd\r"
expect "*#"
send "$cmd\r"
send "exit\r"
expect eof
#interact
