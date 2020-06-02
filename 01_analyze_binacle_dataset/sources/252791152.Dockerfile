FROM centos:7  
MAINTAINER Cyberious  
  
RUN yum install ruby-devel gcc make rpm-build wget unzip -y && \  
gem install --no-ri \--no-rdoc fpm && yum clean all  

