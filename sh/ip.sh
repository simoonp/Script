#! /bin/bash

echo 是主机还是从机？（1：从机，2：主机）
read your_id
if  (($your_id == 1)) ; then
	#statements
	echo 你选择了设置ros从机
elif (( $your_id==2 )); then
		#statements
	echo 你选择了设置ros主机	
else
	echo 错误error！！！
fi

if (( $your_id==2 || $your_id==1 )); then
	# 读取网卡信息，写入 all_net
	ifconfig > all_net
	# 挑选出网卡名称,写入net_name
	sed -n '/flag/p' all_net | awk '{print $1}' > net_name
	# 删除网卡名称后多余的 : ，保存到new_name
	sed -n 's/://p' net_name > new_name 
	# 列出目前的网卡ip和网卡名称
	ifconfig

	echo 可供选择的网卡：
	cat new_name

	#删除临时文件
	rm all_net net_name new_name
	echo '输入需要的网卡名称'

	read name
	# iwconfig 只查看现有网络连接情况

	# 仅获取 name 网卡的IP,复制给local_ip，注=之间没有空格

	local_ip=$(ifconfig $name | grep "inet " | awk '{ print $2}')

	echo $local_ip

	#temp=$(cat ~/.bashrc | sed -n "/^export ROS_HOSTNAME/p")


	# 获取行号，可以用，暂时放弃此方式注释ROS_HOSTNAME
	num=$(cat ~/.bashrc | sed -n '/^export ROS_HOSTNAME/=')
	time=$(date)
	# 判断是否找到ROS_HOSTNAME
	if test -n "$num";then
		echo "找到目前使用的ROS_HOSTNAME，在 $num 行"
		#注释已有的ROS_HOSTNAME
		sed -i "s/^export ROS_HOSTNAME/#&/g" ~/.bashrc
		# 根据刚才的行号，添加新的本机ip,在sed语句中 使用 "" 可以在里面应用shell变量
		sed -i  "$num a\export ROS_HOSTNAME=$local_ip #修改时间 $time" ~/.bashrc
		echo ROS_HOSTNAME修改完成
	else
		echo "原.bashrc文件中没有ROS_HOSTNAME，或者已被注释，将在最后一行插入ROS_HOSTNAME"
		#由于sed语句的特性，不能再像之前那样再""中使用shell变量，这样会导致 $a 在文本最后一行，无法使用，所以在' '中对shell变量使用''括起来，以便使用shell变量
		sed -i '$a\export ROS_HOSTNAME='$local_ip' #修改时间 ' ~/.bashrc
	fi

	echo " "
	echo 添加的ip为：
	sed -n "/^export ROS_HOSTNAME/p" ~/.bashrc
	echo " "

	if (( $your_id == 1 )); then
		echo 是否需要修改ROS_MASTER_URI ip（0：不需要，1：需要）

		read num

		if (($num == 1)); then
			# echo 测试
			num=$(cat ~/.bashrc | sed -n '/^export ROS_MASTER_URI/=')
			if test -n "$num";then
				echo "已发现 ROS_MASTER_URI 在$num行"
				echo 请输入需要替换的ip
				read master_ip
				#注释已有的 ROS_MASTER_URI
				sed -i "s/^export ROS_MASTER_URI/#&/g" ~/.bashrc
				sed -i  "$num a\export ROS_MASTER_URI=http://$master_ip:11311 #修改时间 $time" ~/.bashrc
				echo ROS_MASTER_URI 修改完成
			else
				echo "原.bashrc文件中没有 ROS_MASTER_URI ，或者已被注释，将在最后一行插入 ROS_MASTER_URI "
				sed -i '$a\export ROS_MASTER_URI=http://'$master_ip':11311 #修改时间 ' ~/.bashrc
				echo ROS_MASTER_URI 修改完成
			fi
			echo " "
			echo 添加的ip为：
			sed -n "/^export ROS_MASTER_URI/p" ~/.bashrc
			echo " "
		fi

		echo 是否需要修改turnUp.sh（自启动脚本）（0：不需要，1：需要；确保此脚本在在主机上执行）
		read num
		if (( $num==1 )); then
			if (( $your_id==1 )); then
				echo 从机不需要修改该脚本
			elif (( $your_id==2 )); then
				# 替换 ROS_HOSTNAME
				num=$(cat ~/sh/turnUp.sh | sed -n '/^export ROS_HOSTNAME/=')
				# 判断是否找到 ROS_HOSTNAME
				if test -n "$num";then
					echo "找到目前使用的ROS_HOSTNAME，在 $num 行"
					#注释已有的ROS_HOSTNAME
					sed -i "s/^export ROS_HOSTNAME/#&/g" ~/sh/turnUp.sh
					sed -i  "$num a\export ROS_HOSTNAME=$local_ip #修改时间 $time" ~/sh/turnUp.sh
					echo ROS_HOSTNAME 更新完成
				else
					echo "原.bashrc文件中没有ROS_HOSTNAME，或者已被注释，将在最后一行插入ROS_HOSTNAME"
					#由于sed语句的特性，不能再像之前那样再""中使用shell变量，这样会导致 $a 在文本最后一行，无法使用，所以在' '中对shell变量使用''括起来，以便使用shell变量
					sed -i '$a\export ROS_HOSTNAME='$local_ip' #修改时间 ' ~/sh/turnUp.sh
					echo ROS_HOSTNAME 更新完成
				fi

				# 替换 ROS_MASTER_URI
				num=$(cat ~/sh/turnUp.sh | sed -n '/^export ROS_MASTER_URI/=')
				if test -n "$num";then
					echo "已发现 ROS_MASTER_URI 在$num行"
					#注释已有的 ROS_MASTER_URI
					sed -i "s/^export ROS_MASTER_URI/#&/g" ~/sh/turnUp.sh
					sed -i  "$num a\export ROS_MASTER_URI=http://$local_ip:11311 #修改时间 $time" ~/sh/turnUp.sh
					echo ROS_MASTER_URI 更新完成
				else
					echo "原.bashrc文件中没有 ROS_MASTER_URI ，或者已被注释，将在最后一行插入 ROS_MASTER_URI "
					sed -i '$a\export ROS_MASTER_URI=http://'$local_ip':11311 #修改时间 ' ~/sh/turnUp.sh
					echo ROS_MASTER_URI 更新完成
				fi
			fi
		fi

	elif (( $your_id==2 )); then
		num=$(cat ~/.bashrc | sed -n '/^export ROS_MASTER_URI/=')
		if test -n "$num";then
			echo "已发现 ROS_MASTER_URI 在$num行"
			#注释已有的 ROS_MASTER_URI
			sed -i "s/^export ROS_MASTER_URI/#&/g" ~/.bashrc
			sed -i  "$num a\export ROS_MASTER_URI=http://$local_ip:11311 #修改时间 $time" ~/.bashrc
			echo ROS_MASTER_URI 修改完成
		else
			echo "原.bashrc文件中没有 ROS_MASTER_URI ，或者已被注释，将在最后一行插入 ROS_MASTER_URI "
			sed -i '$a\export ROS_MASTER_URI=http://'$local_ip':11311 #修改时间 ' ~/.bashrc
			echo ROS_MASTER_URI 修改完成
		fi
		echo 添加的ip为：
		sed -n "/^export ROS_MASTER_URI/p" ~/.bashrc
		echo " "
	fi

	source ~/.bashrc
	echo 已source ~/.bashrc
fi