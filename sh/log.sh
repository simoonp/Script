#!/bin/bash
# 此文加放在 /etc/profile.d/ 目录下，每次开启新终端，自动执行 script 指令，记录所有终端内容，并将结果保存在 ~/log 下
DT=$(date "+%Y_%m_%d %H:%M:%S" | sed 's/ /-/g' | sed 's/:/_/g').log
echo $DT
touch  ~/log/$DT
script -a ~/log/$DT
