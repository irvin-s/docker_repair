FROM centos:7.3.1611  
RUN sed -i '/tsflags=nodocs/d' /etc/yum.conf  
  

