#!/bin/bash
# 不同于 cut_mp3_by_mp3.sh
# 这里使用原视频文件来获取音频时长，截取时间方便控制
start="00:00:09"
for i in $(ls *.mp4)
do
	len=$(ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1  $i)	# 计算总时长
	len=$(echo $len | cut -d'.' -f 1)	# 时长取整
	echo $len	
	len=$((len -9))	# 保留的时长
	echo $len
	tmpname=$(echo $i | cut -d'.' -f 1)
	tmpname=$tmpname.mp3
	oldname=$tmpname.old 
	mv $tmpname $oldname  # 备份文件
	echo $tmpname
	echo "执行： ffmpeg -ss $start -i $oldname -t $len -copyts $tmpname"
	ffmpeg -ss $start -i $oldname -t $len -copyts $tmpname
	# exit
done
