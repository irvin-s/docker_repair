FROM ubuntu:16.04  
MAINTAINER Cuteribs <ericfine1981@live.com>  
  
# Switches deb source to China mirror  
RUN sed -i.bak 's/archive/cn\\.archive/' /etc/apt/sources.list  
  
# Deploys files  
ADD ./packages/xware.tar.gz /app/  
ADD ./packages/kcp.tar.gz /app/  
ADD ./packages/3proxy.tar.gz /app/  
COPY ./packages/*.deb /app/  
COPY ./*.sh /app/  
RUN chmod +x /app/*.sh  
  
WORKDIR /app  

