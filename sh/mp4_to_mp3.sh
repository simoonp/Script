# 通过ffmpeg提取目录下所有的mp4文件的音频数据，保存为mp3格式
#!/bin/bash
for i in $(ls)
do
	tmpname=$(echo $i | cut -d'.' -f 1)
	tmpname=$tmpname.mp3
	echo $tmpname	
	ffmpeg -i $i -f mp3 -vn $tmpname
	# sleep 300
done
