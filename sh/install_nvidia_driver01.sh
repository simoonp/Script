echo "确保以进入root权限状态"
sleep 5s
echo "检查系统是否检测到显卡"
lspci | grep -i nvidia
sleep 4s
echo "=========================卸载原有nvidia驱动"
sleep 5s
apt-get purge nvidia*
apt-get autoremove -y
nvi=$(ls NVIDIA-Linux-*)
./$nvi --uninstall

echo "=========================安装依赖"
sleep 5s
apt-get install gcc g++ make -y
apt-get install build-essential gcc-multilib dkms -y


echo "=========================禁用nouveau驱动"
sleep 5s
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist-nouveau.conf
echo "blacklist lbm-nouveau" >> /etc/modprobe.d/blacklist-nouveau.conf
echo "options nouveau modeset=0" >> /etc/modprobe.d/blacklist-nouveau.conf
echo "alias nouveau off" >> /etc/modprobe.d/blacklist-nouveau.conf
echo "alias lbm-nouveau off" >> /etc/modprobe.d/blacklist-nouveau.conf


echo "=========================关闭nouveau"
sleep 5s
echo options nouveau modeset=0 | tee -a /etc/modprobe.d/nouveau-kms.conf 


echo "=========================关闭图形界面"
sleep 5s
systemctl set-default multi-user.target



echo "=========================获取kernel source"
sleep 5s
apt-get install linux-source -y
apt-get install linux-headers-$(uname -r) -y


echo "=========================重启"
sleep 5s
update-initramfs -u 
reboot
