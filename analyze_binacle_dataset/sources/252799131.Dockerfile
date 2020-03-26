FROM debian:8.0  
MAINTAINER andystanton  
ENV LANG C.UTF-8  
RUN apt-get update -qq -y && \  
apt-get install -y patch python python3 && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

