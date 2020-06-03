FROM i386/ubuntu:14.04  
MAINTAINER lozovsky <lozovsky@apriorit.com>  
  
# Refresh package repostories  
RUN apt-get update  
  
# Install essential packages for building and packaging C++ software  
RUN apt-get install -y \  
automake \  
build-essential \  
cmake \  
curl \  
debhelper \  
elfutils \  
fakeroot \  
gcc \  
g++ \  
git \  
lintian \  
pkg-config \  
rpm \  
&& exit  
  
# Install Linux kernel development files  
RUN apt-get install -y \  
linux-headers-3.19.0-79-generic \  
linux-headers-4.2.0-42-generic \  
linux-headers-4.4.0-93-generic \  
sparse \  
&& exit  
  
# Install miscellaneous libraries and dependencies  
RUN apt-get install -y \  
bison \  
flex \  
libboost-dev \  
libjson-c-dev \  
libnl-3-dev \  
libnl-genl-3-dev \  
libnl-route-3-dev \  
libsqlite3-dev \  
zlib1g-dev \  
libmagic-dev \  
&& exit  
  
# Remove cached packages and repository contents to conserve disk space  
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*  
  
# Copy our Docker scripts directory into the image  
ADD docker/* /tmp/docker/  
  
# Download, build, and install our custom dependencies  
RUN /tmp/docker/install-openssl  
RUN /tmp/docker/install-libpcap  
RUN /tmp/docker/install-yaml-cpp  
RUN /tmp/docker/install-cmake-3.2.0  
RUN /tmp/docker/install-curl  
  
# Remove our scripts from the image  
RUN rm -r /tmp/docker  

