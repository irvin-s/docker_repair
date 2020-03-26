FROM combro2k/ruby-rvm:latest  
MAINTAINER Martijn van Maurik <docker@vmaurik.nl>  
  
USER root  
  
VOLUME ["/data"]  
  
ADD resources/bin/ /usr/local/bin/  
  
RUN /bin/bash -c '/usr/local/bin/setup.sh build'  
  
ADD resources/etc/ /etc/  

