############################################################  
# Dockerfile: CentOS6 & easy-rsa  
############################################################  
FROM centos:centos6  
  
MAINTAINER CarbonSphere <CarbonSphere@gmail.com>  
  
# Set environment variable  
ENV HOME /root  
ENV TERM xterm  
  
RUN yum -y update; yum -y install epel-release; yum -y clean all  
  
RUN yum -y install easy-rsa; yum -y clean all  
  
RUN ln -s /usr/share/easy-rsa/2.0 /er  
  
ENV EASY_RSA /usr/share/easy-rsa/2.0  
ENV KEY_CONFIG $EASY_RSA/openssl-1.0.0.cnf

