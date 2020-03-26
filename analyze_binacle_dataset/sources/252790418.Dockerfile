############################################################  
# Dockerfile: CentOS6 & Epel Repo Base Image  
############################################################  
FROM centos:centos6  
  
MAINTAINER CarbonSphere <CarbonSphere@gmail.com>  
  
# Set environment variable  
ENV HOME /root  
ENV TERM xterm  
ENV LANG en_US.UTF-8  
ENV LC_ALL en_US.UTF-8  
  
# Install epel release  
RUN yum -y install epel-release; yum -y clean all  
  

