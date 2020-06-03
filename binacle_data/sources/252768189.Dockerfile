FROM debian  
MAINTAINER tescom <tescom@atdt01410.com>  
  
RUN mkdir -p /data  
RUN chmod 777 /data  
  
VOLUME /data  
  
ENTRYPOINT /usr/bin/tail -f /dev/null  

