FROM ubuntu:16.04  
RUN sed -i "s/archive.ubuntu./mirrors.aliyun./g" /etc/apt/sources.list  
  
RUN apt-get update &&\  
apt-get install -y \  
vim less \  
net-tools iputils-ping curl netcat \  
nfs-common mysql-client  
  
ADD entrypoint /usr/local/bin  
  
ENTRYPOINT entrypoint  
  

