# Script
本仓库主要用于存放自动化脚本

主要以Shell脚本为主

[从视频中提取音频](sh/mp4_to_mp3.sh)：使用ffmpeg提取音频

[截取部分音频01](sh/cut_mp3_by_mp3.sh)：使用ffmpeg截取部分音频

[截取部分音频02](sh/cut_mp3_by_mp3.sh)：使用ffmpeg截取部分音频

[ubuntu18_static_ip.sh](sh/ubuntu18_static_ip.sh)：设置静态IP与网关

[ip.sh](sh/ip.sh)：设置ROS的主机与从机IP

[start.sh](sh/start.sh)、[trans.sh](trans.sh)：从远程主机上下载视频，结合定时任务使用

[vs_error.sh](sh/vs_error.sh)：修复VScode更新后无法远程连接主机/wls虚拟机的问题，配合[vs_error](sh/vs_error )使用

[setlog.sh](sh/setlog.sh)：通过`script`指令，记录自动记录所有终端的数据，并将记录记过保存到`~/log/`中

[install_nvidia_driver01.sh](sh/install_nvidia_driver01.sh)和[install_nvidia_driver02.sh](sh/install_nvidia_driver02.sh)：用于给exsi虚拟机安装nvidia和cuda驱动

[docker_install.sh](sh/docker_install.sh)：安装docker

[nvidia-container-runtime-script.sh](sh/nvidia-container-runtime-script.sh)：安装docker nvidia-container

[set_gpu_web.sh](sh/set_gpu_web.sh)：设置 gpu-jupyter

[read.sh](sh/read.sh)：批量设置gpu-jupyter

[vnc_set01](sh/vnc_set01)、[vnc_set02](sh/vnc_set02)：给docker容器配置vnc服务端，注意脚本里的默认用户名与相关文件路径
