FROM ubuntu:latest  
MAINTAINER Alban Linard <alban.linard@unige.ch>  
  
ADD bin/install /root/install  
ADD bin/colorize /usr/local/bin  
RUN chmod a+x /usr/local/bin/colorize && \  
apt-get update --yes && \  
apt-get install --yes sudo && \  
/root/install /usr/local && \  
rm -rf /root/install /var/lib/apt/lists/* /tmp/* /var/tmp/*  

