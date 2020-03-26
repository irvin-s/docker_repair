FROM centos:centos7  
MAINTAINER 2k0ri esc13245@gmail.com  
  
RUN yum swap -y fakesystemd systemd  
RUN yum install -y initscripts  
  
CMD ["/sbin/init", "3"]  

