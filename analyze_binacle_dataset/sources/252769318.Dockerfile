FROM ubuntu:14.04  
MAINTAINER André Nishitani <andre.nishitani@gmail.com>  
  
# Script to add and clean squid-deb-proxy entries  
ADD ./scripts /scripts  
  
RUN chmod +x /scripts/init_squid_cache.sh /scripts/stop_squid_cache.sh  
  
RUN apt-get install -y wget  
  
CMD [ '/bin/bash' ]  

