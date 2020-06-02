FROM aneundorf/centos5-build-svn  
MAINTAINER alexander.neundorf@sharpreflections.com  
  
# install a bunch of development packages  
RUN yum update -y && \  
yum install openssh-server openssh-clients -y  
  

