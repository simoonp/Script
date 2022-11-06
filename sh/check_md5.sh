#!/bin/bash

# 计算一个文件夹下所有文件的md5值，不接参数默认是当前文件夹，可以接1个参数，表示文件夹名
function md5_all {
	if [ $# -eq 0 ]
	then
		echo "没有相函数传递参数，使用默认值(当前文件夹 .)"
		dir_nam="."
	else
		echo "传递了参数 $1"
		dir_nam="$1"
	fi
	tree -dif --noreport "$dir_nam" > .t1 # 带路径只列出文件
	tree -if --noreport "$dir_nam" > .t2 # 带路径列出文件
	awk '{print $0}' .t1 .t2 |sort|uniq -u >.t3 # 删除 t1 与 t2 中的相同部分，等效于 只取文件名，不要文件夹名
	cat .t3 | while read line 
	do
		md5sum "$line" >> .log_md5
	done
	rm .t1 .t2 .t3 
}

echo "5s后开始计算当前文件夹下所有文件的md5值，结果保存在 .log_md5 文件中"
sleep 5s 

num=$#

if [ $num -eq 0 ]
then
	echo "输入了0个参数， 将对该文件夹下所有文件的md5值"
	md5_all
else
	echo "输入了$num个参数"
	for arg in "$@"
	do
		echo "$arg" 
		if [ -d "$arg" ]
		then
			echo "$arg 是文件夹"
			md5_all "$arg"
		elif [ -f "$arg" ]
		then
			echo "$arg 是文件"
			md5sum "$arg"  >> .log_md5
		else
			echo "$arg 既不是文件也不是文件夹"
		fi
	done
fi
