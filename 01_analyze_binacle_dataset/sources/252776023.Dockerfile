FROM bnounours/docker-base-image  
  
MAINTAINER Mickaël Cornière <mickael.corniere@gmail.com>  
  
ENV MM_VERSION=1.9.8  
WORKDIR /opt  
  
COPY install.sh /opt/  
  
RUN chmod +x /opt/install.sh && /opt/install.sh "$MM_VERSION"  
  
COPY start.sh /opt/  
  
RUN chmod +x /opt/start.sh  
  
EXPOSE 8080  
CMD ["/usr/bin/supervisord","-c", "/etc/supervisor/supervisord.conf", "-n"]  

