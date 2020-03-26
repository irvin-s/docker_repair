FROM ubuntu:16.04  
MAINTAINER Chris Weyl <chris.weyl@dreamhost.com>  
  
ENV DEBIAN_FRONTEND=noninteractive  
  
RUN \  
apt-get update && \  
apt-get -y install tayga && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
ENTRYPOINT [ "/usr/sbin/tayga", "--nodetach" ]  

