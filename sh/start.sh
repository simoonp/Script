#! /bin/bash

name=dingfang
ip=192.168.100.102
pw=111
path=/home/dingfang/workdir/video
dir=/mnt/i/video/$(date "+%m%d")

# cd /mnt/i/video
mkdir $dir

echo $dir
echo $path	
# trans.sh	
~/trans.sh $name $ip $pw $dir $path
echo ""
