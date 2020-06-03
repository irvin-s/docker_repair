FROM centos:centos7  
MAINTAINER Cristiano Kliemann  
  
RUN yum -y install epel-release && yum -y update && yum clean all

