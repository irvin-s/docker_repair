# Create from Ubuntu base image  
FROM ubuntu  
  
# Maintainer of Dockerfile  
MAINTAINER dmartinez@erpcya.com  
  
# Update repositories  
RUN \  
apt-get update && \  
apt-get install -y openjdk-7-jdk  
  
#  
RUN \  
apt-get install -y python-software-properties && \  
apt-get install -y openssh-server  
  
CMD /usr/sbin/sshd -D  

