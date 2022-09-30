#!/bin/bash
passwd=123456
cat info | while read line
do
	echo "配置信息为： $line ，准备创建容器"
	sleep 5s
	expect <<-EOF
		set timeout 500
		spawn ./set_gpu_web.sh $line
		expect "*password*"  {sleep 1;  send "$passwd\r"}
		expect "*Retype*password*"  {sleep 1;  send "$passwd\r"}
		set timeout 300
		expect "*finish-set*" {sleep 1; send "666\r"}
EOF
	
done
