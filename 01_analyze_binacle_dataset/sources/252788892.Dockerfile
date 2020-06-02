FROM drokar/centos-s6:latest  
MAINTAINER Charles Drolet-Achkar <charles.drokar@gmail.com>  
  
RUN yum -y install \  
epel-release \  
lsof \  
wget \  
git && \  
yum clean all  

