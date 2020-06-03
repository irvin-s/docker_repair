FROM centos:centos6  
MAINTAINER Taiki Sugawara <buzztaiki@gmail.com>  
  
RUN yum -y install man sysstat  
# install sysstat man pages  
RUN yum -y --setopt=tsflags= reinstall sysstat  
  
COPY entrypoint /  
  
ENTRYPOINT ["/entrypoint"]  

