FROM centos:7  
MAINTAINER Tommy McNeely <tommy@lark-it.com>  
  
RUN yum -y install epel-release wget which; \  
yum -y update; \  
yum clean all  
  

