FROM debian:wheezy  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get -y install mono-devel && \  
apt-get -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

