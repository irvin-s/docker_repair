FROM ubuntu:xenial  
MAINTAINER Truc C. Dao <truc.c.dao@gmail.com>  
  
# Prevent dpkg errors  
ENV TERM=xterm-256color  
  
# Set mirrors to VN  
RUN sed -i "s/http:\/\/archive./http:\/\/vn.archive./g" /etc/apt/sources.list  
  
# Install node.js  
RUN apt-get update && \  
apt-get install curl sudo build-essential -y && \  
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - && \  
apt-get install -y nodejs git  
  
# Add entrypoint script  
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh  
RUN chmod +x /usr/local/bin/entrypoint.sh  
ENTRYPOINT ["entrypoint.sh"]  
  
LABEL application=mango  

