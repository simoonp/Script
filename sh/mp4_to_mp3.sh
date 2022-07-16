# 通过ffmpeg提取目录下所有的mp4文件的音频数据，保存为mp3格式
# 若要转换其他格式的视频，只需将 脚本中的 input_format 换成对应的视频后缀名
# 若要保存为其他格式的音频，只需修改 output_format 为对应的后缀名
#!/bin/bash
input_format=mp4
output_format=mp3
for i in $(ls *.$input_format)
do
	tmpname=$(echo $i | cut -d'.' -f 1)
	tmpname=$tmpname.$output_format
	echo $tmpname	
	ffmpeg -i $i -f $output_format -vn $tmpname
done
