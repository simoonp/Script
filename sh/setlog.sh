#!/bin/bash
cd ~
mkdir log
# wget https://gitee.com/simoonp/rosdistro_backup/raw/master/log.bash 
wget https://gitee.com/simoonp/rosdistro_backup/raw/master/log.sh 
sudo apt install dos2unix 
dos2unix log.sh

chmod +x log.sh 
sudo cp log.sh /etc/profile.d/ 
