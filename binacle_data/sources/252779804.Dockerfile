# Docker image for the OpenAM configurator tool  
FROM java:8  
MAINTAINER kim@conduct.no  
WORKDIR /var/tmp  
  
COPY master.properties /var/tmp/  
COPY second.properties /var/tmp/  
COPY config.sh /var/tmp/  
  
VOLUME ["/opt/repo"]  
  
CMD ["/var/tmp/config.sh"]  
  

