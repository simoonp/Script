#! /bin/bash
flag_test=1	# 测试flag

while getopts ":h" optname
do
	case "$optname" in
		"h")
			echo "至少需要4个参数，指定用户名、将要创建的容器名，映射的ssh端口、web端口，2个可选参数为镜像名和卷挂载位置"
			echo '容器信息保存在 info_docker 中'
			echo '例如：'
			echo '     ./set_gpu_web.sh user_name docker_name ssh_port web_port'
			exit
			;;
	esac
done
if [ ! -n "$5" ]; then
	echo "未指定镜像，使用默认镜像"
	echo " "
	images_name="72b7a5a0edc8"
else
	images_name=$5
fi

if [ ! -n "$6" ]; then
	echo "未指定卷挂载的位置"
	echo " "
	vol_path="/home/jovyan/work"
else
	vol_path=$6
fi
name=$2
path=/home/$1/$name
ssh_port=$3
web_port=$4
eth=ens256
local_ip=$(ifconfig $eth | grep "inet " |awk '{ print $2}')

if (($flag_test == "1")); then
	sleep 5s
	mkdir $path
fi

echo "用户名为 $1"
echo "容器名为 $name"
echo "容器暴露的ssh端口：$ssh_port"
echo "容器暴露的web端口：$web_port"
echo "镜像名称为：$images_name"
echo "卷挂载的位置：$vol_path"
set_cuda=set_cuda_path.sh
echo "ssh端口为 $ssh_port 密码默认为123456"', web端： http://'"$local_ip:$web_port web端密码为：gpu-jupyter" >> /home/$1/info_docker
cp $set_cuda $path/
ls $path
echo "docker容器名称：$name，文件夹路径：$path  将被挂载到容器上"
echo "创建文件夹"


if (($flag_test == "0")); then
	echo "测试状态"
	exit
elif (($flag_test == "1")); then

	echo "非测试状态, 即将开始部署容器"
	sleep 5s
	# echo "退出测试"
	# exit
fi
# exit

echo "更改文件夹权限为 777"
if (($flag_test == "1")); then
	sleep 5s
	chmod 777 $path
fi
echo "创建容器"
if (($flag_test == "1")); then
	sleep 5s
	docker run --name=$name -d  --gpus all -it -p $ssh_port:22 -p $web_port:8888 -v $path:$vol_path -e GRANT_SUDO=yes -e JUPYTER_ENABLE_LAB=yes --user root $images_name
fi
echo "为root用户设置密码，默认为 123456"
if (($flag_test == "1")); then
	sleep 5s
	docker exec -it $name /bin/bash -c "passwd"
fi

echo "为容器安装ssh、vim、net-tools"
if (($flag_test == "1")); then
	sleep 5s
	docker exec -it $name /bin/bash -c "apt update"
	docker exec -it $name /bin/bash -c "apt install vim openssh-server net-tools -y"
	echo "重启ssh服务"
	docker exec -it $name /bin/bash -c "/etc/init.d/ssh restart"
fi

if (($flag_test == "1")); then
	sleep 1s
fi

echo "设置 cuda_path "
if (($flag_test == "1")); then
	sleep 5s
	docker exec -it $name /bin/bash -c "$vol_path/$set_cuda"
fi

echo "重启docker"
if (($flag_test == "1")); then
	sleep 5s
	docker exec -it $name /bin/bash -c "/etc/init.d/ssh restart"
fi

echo "finish-set"
