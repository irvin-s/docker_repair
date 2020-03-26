FROM ubuntu:trusty  
MAINTAINER eterna2 <eterna2@hotmail.com>  
  
RUN apt-get update && apt-get install -y \  
automake \  
autotools-dev \  
g++ \  
git \  
libcurl4-gnutls-dev \  
libfuse-dev \  
libssl-dev \  
libxml2-dev \  
make \  
pkg-config \  
supervisor  
  
WORKDIR /home/  
  
COPY scripts/install.sh /tmp/install.sh  
RUN chmod +x /tmp/install.sh  
RUN . /tmp/install.sh  
  
COPY config/fuse.conf /etc/fuse.conf  
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
RUN mkdir scripts  
COPY scripts/runS3fs.sh scripts/runS3fs.sh  
RUN chmod +x scripts/*  
  
CMD ["/usr/bin/supervisord"]

