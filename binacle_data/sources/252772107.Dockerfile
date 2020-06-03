FROM centos:7  
LABEL maintainer Parker Johansen <johansen.parker@gmail.com>  
  
ARG steamdir=/steamcmd  
  
RUN yum update -y && \  
yum install -y glibc.i686 libstdc++.i686 wget && \  
mkdir $steamdir && \  
cd $steamdir && \  
wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \  
tar -xvzf steamcmd_linux.tar.gz  
  
CMD [ "/bin/bash" ]  

