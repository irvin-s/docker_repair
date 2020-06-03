FROM centos:6  
MAINTAINER Chowkidar <dev@chowkidar.io>  
  
RUN yum update -y && \  
yum install -y epel-release && \  
yum clean all  
  
RUN yum makecache && \  
yum groupinstall -y 'Development Tools' && \  
yum install -y yum-utils redhat-rpm-config rpm-{build,sign} spectool && \  
yum clean all && \  
rm -rf /var/cache/*  

