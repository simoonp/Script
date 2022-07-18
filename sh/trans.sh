#!/usr/bin/expect

set timeout -1


set name [lindex $argv 0]
set ip [lindex $argv 1]
set pw [lindex $argv 2]
set dir [lindex $argv 3]
set path [lindex $argv 4]

# send "pwd\r"
#spawn echo $ip
#spawn echo $pw
#spawn echo $dir
#spawn echo $path
# name=$(date "+%m%d")tmcp

# /home/dingfang/workdir/video/24513717/

# 传输文件
spawn scp $name@$ip:$path/**.xml $dir/
expect "*password"
send "$pw\r"
expect eof

spawn scp $name@$ip:$path/**.flv $dir/
expect "*password"
send "$pw\r"
expect eof


spawn scp $name@$ip:$path/24513717/**.xml $dir/
expect "*password"
send "$pw\r"
expect eof

spawn scp $name@$ip:$path/*24513717/*.flv $dir/
expect "*password"
send "$pw\r"
expect eof

# 删除文件

spawn ssh $name@$ip
expect "*password"
send "$pw\r"
expect "*login"
send "cd ~/workdir/video/ \r"
# expect "*video"
sleep 1
send "rm **.xml\r"
# expect eof
sleep 2
send "rm **.flv\r"
# expect eof
sleep 2
send "cd 24513717\r"
sleep 1
send "rm **.flv\r"
sleep 2
send "rm **.xml\r"
sleep 2
send "exit \r"
