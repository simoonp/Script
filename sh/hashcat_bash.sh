apt-get update && apt-get install -y --no-install-recommends \
        ocl-icd-libopencl1 \
        clinfo pkg-config
        
mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
    

echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
    
apt-get update && \
    apt-get install -y wget make clinfo build-essential git libcurl4-openssl-dev libssl-dev zlib1g-dev libcurl4-openssl-dev libssl-dev pciutils
    
update-pciids

git clone https://github.com/hashcat/hashcat.git && cd hashcat && make install -j4
