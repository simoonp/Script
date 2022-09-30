echo "请提前切换到 root"
sleep 2s

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
echo "注意检查文件夹是否存在"
sleep 5s
echo "export PATH=$cuda_path1:"'$PATH' >> /home/gpu/.bashrc
echo "export LD_LIBRARY_PATH=$cuda_path2:"'$LD_LIBRARY_PATH' >> /home/gpu/.bashrc
echo "开启图形界面"
sleep 5s
systemctl set-default graphical.target

echo "重启"
sleep 5s
reboot
