#!/usr/bin/expect
set timeout -1
set file [lindex $argv 0]
spawn scp $file root@192.168.151.93:/export/servers
expect {
	"(yes/no)?" {
		send "yes\r"
		expect "password:"
		send "pass\r"
	}
	"password" {
		send "pass\r"
	}
}
expect eof
