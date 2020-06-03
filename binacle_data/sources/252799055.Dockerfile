FROM jprjr/lighttpd  
MAINTAINER Leonid Suprun <mr.slay@gmail.com>  
  
RUN rm /etc/machine-id  
  
ADD init.sh /  
  
ENTRYPOINT ["/init.sh"]  

