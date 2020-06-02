FROM orboan/docker-centos-supervisor-ssh  
MAINTAINER andres  
  
RUN yum update -y && \  
yum install -y openssl shellinabox  
  
RUN \  
yum clean all && rm -rf /tmp/yum*  
  
ENV SHELLINABOX_PORT=9104  
ENV USER=docker  
ENV PASSWORD=asix  
  
ADD container-files /  
  
EXPOSE 4200  

