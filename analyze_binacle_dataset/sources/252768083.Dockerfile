FROM ubuntu:16.04  
LABEL maintainer="adam.wallis@gmail.com"  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive && \  
apt-get dist-upgrade -y && \  
apt-get install -y build-essential && \  
apt-get install -y python2.7 && \  
apt-get install -y python-pip &&\  
apt-get install -y vim && \  
apt-get autoremove -y && \  
apt-get clean -y && rm -rf /var/lib/apt/lists/*  
  
ENTRYPOINT [ "/bin/bash" ]  

