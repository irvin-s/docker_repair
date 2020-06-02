FROM centos:centos7  
MAINTAINER Virendra Singh Bhalothia <bhalothia@theremotelab.com>  
  
RUN yum -y update; yum clean all  
RUN yum -y install epel-release tar curl git; yum clean all  

