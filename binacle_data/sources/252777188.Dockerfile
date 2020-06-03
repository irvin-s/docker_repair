FROM ubuntu:trusty  
# IMPORTANT: this should be the same as the one used by ceph/daemon  
# otherwise dependencies are not going to match (e.g. libboost_threads)  
  
MAINTAINER Ivo Jimenez <ivo.jimenez@gmail.com>  
  
ARG DEBIAN_FRONTEND=noninteractive  
ENV REF="luminous"  
# install deps  
RUN apt-get update && apt-get install -y wget lxc ccache \  
valgrind gdb python-virtualenv gdisk kpartx hdparm jq xmlstarlet && \  
wget https://raw.githubusercontent.com/ceph/ceph/$REF/install-deps.sh && \  
wget https://raw.githubusercontent.com/ceph/ceph/$REF/debian/control && \  
mkdir debian && mv control debian && \  
chmod 755 install-deps.sh && ./install-deps.sh && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* debian/  
ADD scripts/* /root/bin/  
ENV PATH=$PATH:/root/bin  
WORKDIR /ceph  

