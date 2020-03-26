FROM scratch  
  
MAINTAINER joe <joe@valuphone.com>  
  
LABEL os="linux" \  
os.distro="debian" \  
os.version="jessie"  
  
ADD build/rootfs.tar.gz /  
  

