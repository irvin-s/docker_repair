FROM centos:centos6  
MAINTAINER Piotr Czapla <piotr.czapla@bright-it.com>  
# based on devopsil puppet  
ENV PUPPET_VERSION 3.8.2  
RUN rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs && \  
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm  
  
RUN yum update -y && \  
yum -y -d 0 -e 0 install yum-utils -y && \  
yum-config-manager --enable centosplus >& /dev/null && \  
yum -y -d 0 -e 0 install puppet-$PUPPET_VERSION && \  
yum -y -d 0 -e 0 install sudo && \  
yum -y -d 0 -e 0 install openssl-1.0.1e-48.el6_8.3.i686 && \  
yum clean all  

