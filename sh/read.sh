#!/bin/bash

# 批量创建脚本，需要 info 文件
# info 中保存 用户名、将要创建的容器名，映射的ssh端口、web端口，2个可选参数为镜像名和卷挂载位置
# 例如：
# gpu gyp 2751 8148
# gpu ljy 2851 8248

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
