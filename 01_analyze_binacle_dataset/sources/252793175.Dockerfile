# Floridaman  
# docker build -t floridaman .  
#  
FROM centos:centos7  
  
LABEL maintainer Dannen Harris version 1.0  
  
RUN yum -y -q -e 0 install nano \  
yum -y clean all  

