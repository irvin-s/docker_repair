FROM conghui/centos  
  
MAINTAINER Conghui He <heconghui@gmail.com>  
  
RUN yum update -y && yum install -y xeyes && yum clean all  
  
CMD "/usr/bin/xeyes"  

