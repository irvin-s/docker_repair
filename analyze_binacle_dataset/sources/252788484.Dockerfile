FROM phusion/baseimage:0.9.22  
  
MAINTAINER Jonas <jonas.m.andreasson@gmail.com>  
  
# Install node.js  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \  
apt-get install -y -q nodejs && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

