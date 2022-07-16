#!/bin/bash
# 截取从 start 到音频结束 这段音频
# 把 mp3 修改为其他格式，也适用于其他格式的音频和视频
start="00:00:09"
for i in $(ls *.mp3)
do
	len=$(ffmpeg -i $i 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed s/,//)	# 计算总时长
	tmpname=$i
	oldname=$tmpname.old
	mv $tmpname $oldname	# 备份原文件
	#echo $tmpname
	echo "执行： ffmpeg -ss $start -i $oldname -to $len -copyts $tmpname"
	ffmpeg -ss $start -i $oldname -to $len -copyts $tmpname # 开始截取
done
