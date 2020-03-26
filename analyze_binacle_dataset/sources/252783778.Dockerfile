FROM centos:6  
MAINTAINER Bing Li <bingli1000@gmail.com>  
  
RUN curl -o /etc/yum.repos.d/2600hz.repo http://repo.2600hz.com/2600hz.repo  
  
WORKDIR /opt/kazoo  

