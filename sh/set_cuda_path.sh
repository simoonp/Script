echo "修改 .bashrc 添加cuda路径："
cuda_path0="/usr/local/cuda"
echo $cuda_path0
du -sh $cuda_path0
cuda_path1="$cuda_path0/bin"
echo $cuda_path1
du -sh $cuda_path1
cuda_path2="$cuda_path0/lib64"
echo $cuda_path2
du -sh $cuda_path2
echo "注意检查文件夹是否存在"
sleep 5s
echo 'CUDA_HOME=$CUDA_HOME:'"$cuda_path0" >> /.bashrc
echo "export PATH=$cuda_path1:"'$PATH' >> /.bashrc
echo "export LD_LIBRARY_PATH=$cuda_path2:"'$LD_LIBRARY_PATH' >> /.bashrc
echo 'CUDA_HOME=$CUDA_HOME:'"$cuda_path0" >> $HOME/.bashrc
echo "export PATH=$cuda_path1:"'$PATH' >> $HOME/.bashrc
echo "export LD_LIBRARY_PATH=$cuda_path2:"'$LD_LIBRARY_PATH' >> $HOME/.bashrc

echo "Finished"
