FROM centos:7  
  
MAINTAINER Jason Cust <jason@centralping.com>  
  
# Install build/make tools  
RUN yum -y update && \  
yum -y install \  
gcc \  
gcc-c++ \  
make \  
tar \  
git && \  
yum clean all  

