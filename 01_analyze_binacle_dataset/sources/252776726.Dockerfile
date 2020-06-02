FROM centos:latest  
MAINTAINER "Didrik A. Rognstad" <didrik.rognstad@gmail.com>  
# Install dependencies  
RUN yum -y install openssh-clients \  
which \  
libtool \  
make \  
automake \  
gcc \  
gcc-c++ \  
byacc \  
flex \  
rpm-build \  
openssl-devel \  
libxml2-devel \  
boost-devel \  
hwloc-devel \  
curl  
  
# Create folders  
RUN mkdir /compile  
RUN mkdir /artifacts  
  
# Copy in build.sh  
COPY build.sh /  
ENTRYPOINT /build.sh  

