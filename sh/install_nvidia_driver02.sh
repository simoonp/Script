echo "请提前切换到 root"
sleep 2s
user_name=$(ls /home | awk '{print $1}')
echo "当前用户名为：$user_name"
bashrc_path=/home/$user_name/.bashrc
echo "安装nvidia驱动"
nvi=$(ls NVIDIA-Linux-*)
echo "安装的驱动为：$nvi"
sleep 5s
./$nvi -no-opengl-files -no-x-check -no-nouveau-check
# ./NVIDIA-Linux-x86_64-460.91.03_2080Ti.run -no-opengl-files -no-x-check -no-nouveau-check

echo "安装cuda"
cud=$(ls cuda_*)
echo "安装驱动为：$cud"
./$cud --no-opengl-libs
sleep 5s
echo "修改 .bashrc 添加cuda路径："
cuda_path1="/usr/local/cuda/bin"
echo $cuda_path1
du -sh $cuda_path1
cuda_path2="/usr/local/cuda/lib64"
echo $cuda_path2
du -sh $cuda_path2
du -sh $bashrc_path
echo "注意检查文件夹是否存在"
sleep 5s
echo "export PATH=$cuda_path1:"'$PATH' >> $bashrc_path
echo "export LD_LIBRARY_PATH=$cuda_path2:"'$LD_LIBRARY_PATH' >> $bashrc_path

echo "安装cuDNN，请提前下载文件"
sleep 5s
"安装依赖"
dpkg -i libcudnn8_*cuda*_amd64.deb
dpkg -i libcudnn8-dev_*cuda*_amd64.deb
dpkg -i libcudnn8-samples_*cuda*_amd64.deb

echo "cuDNN测试"
cp -r /usr/src/cudnn_samples_v8/ $HOME
cd $HOME/cudnn_samples_v8/mnistCUDNN
make clean 
make
./mnistCUDNN

# 以下是卸载命令
# sudo rm -rf /usr/local/cuda/include/cudnn.h
# sudo rm -rf /usr/local/cuda/lib64/libcudnn*
# sudo rm -rf /usr/include/cudnn.h
# sudo rm -rf /usr/lib/x86_64-linux-gnu/libcudnn*

echo "开启图形界面"
sleep 5s
systemctl set-default graphical.target

echo "重启"
sleep 5s
reboot
