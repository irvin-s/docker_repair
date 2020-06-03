FROM ubuntu:latest  
MAINTAINER winsent <pipetc@gmail.com>  
  
RUN apt-get -y update && apt-get -y install \  
wget \  
gcc \  
libc-dev \  
zlib1g-dev  
  
WORKDIR /osm  
  
ADD . .  
  
RUN gcc osmconvert.c -lz -O3 -o /usr/bin/osmconvert && \  
gcc osmfilter.c -O3 -o /usr/bin/osmfilter && \  
gcc osmupdate.c -o /usr/bin/osmupdate  

