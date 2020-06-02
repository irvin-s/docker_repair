FROM centos:centos6  
MAINTAINER Fulvio Meden <caligin35+cpr@gmail.com>  
  
RUN rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm  
RUN yum install -y puppet tar

