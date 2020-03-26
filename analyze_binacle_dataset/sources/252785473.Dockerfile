FROM column/base:v1  
  
MAINTAINER Column Fang <column.fang@gmail.com>  
  
COPY files /  
  
RUN \  
# Install required packages  
apt-get update && \  
apt-get -y install openjdk-8-jdk git-core gnupg flex bison gperf \  
build-essential zip curl zlib1g-dev gcc-multilib g++-multilib \  
libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev \  
lib32z1-dev ccache libgl1-mesa-dev libxml2-utils xsltproc \  
unzip python && \  
  
# Cleanup  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

