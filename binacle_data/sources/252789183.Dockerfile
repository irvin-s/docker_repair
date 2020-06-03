FROM alpine  
MAINTAINER MO  
  
# Include dist  
ADD dist/ /root/dist/  
  
# Run install script  
RUN /root/dist/install.sh  
  
# Start supervisor  
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]  

