echo "=======添加源==========="
curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | \
	  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | \
	  sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt-get update

echo "========安装=========="
sudo apt-get install nvidia-container-runtime -y

echo "==========重启docker ========="
sudo systemctl restart docker



