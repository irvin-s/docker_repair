FROM ubuntu:trusty  
  
RUN apt-get update && \  
apt-get install -y software-properties-common && \  
add-apt-repository -y ppa:ubuntu-lxc/lxd-stable && \  
apt-get update && \  
apt-get install -y \  
curl \  
wget \  
man-db \  
golang \  
git-core \  
vim  
  
RUN useradd -m -G sudo docker  
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
  
USER docker  
  
RUN mkdir -p /home/docker/go  
  
CMD ["/bin/bash"]  

