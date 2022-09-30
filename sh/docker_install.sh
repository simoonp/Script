echo "提前切换到 root"
sleep 5s

echo "卸载原先的Docker"
sleep 5s
apt-get remove docker docker-engine docker.io containerd runc

echo "更新软件源，安装相关工具"
sleep 5s
apt update
apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y

echo "添加Docker官方的GPG密钥"
sleep 5s
curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

echo "设置稳定版仓库"
sleep 5s
add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/ $(lsb_release -cs) stable"

echo "安装 Docker Engine-Community"
sleep 5s
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y

echo "测试 Docker 是否安装成功"
sleep 5s
docker run hello-world
