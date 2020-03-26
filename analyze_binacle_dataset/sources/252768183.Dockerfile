FROM ubuntu:14.04  
MAINTAINER tescom <tescom@atdt01410.com>  
  
RUN apt-get update && \  
apt-get install -y openssh-server curl make gcc git vim && \  
apt-get clean  
  
CMD rm -f /etc/localtime && \  
ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime  
  
CMD ["/bin/bash"]  

