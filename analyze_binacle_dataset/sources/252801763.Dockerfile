FROM busybox  
MAINTAINER Corey Butler  
  
ADD ./lib /setup  
RUN chmod +x /setup/setup.sh  
  
ENTRYPOINT ["/setup/setup.sh"]  

