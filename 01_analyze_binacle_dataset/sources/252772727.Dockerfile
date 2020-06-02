FROM benpiper/mtwa:base  
LABEL maintainer="ben@benpiper.com"  
LABEL Description="App tier image for the multi-tier web app."  
  
RUN service apache2 restart  
  
EXPOSE 8080/tcp  
EXPOSE 8443/tcp  
# Start apache server  
ENTRYPOINT ["/sbin/entrypoint.sh"]  

