FROM java:8  
MAINTAINER Alexander Lukichev  
EXPOSE 5000  
VOLUME /cfg  
  
VOLUME /app  
  
ADD runjava.sh /  
RUN chmod +x /runjava.sh  
  
WORKDIR /app  
  
ENTRYPOINT ["/runjava.sh"]  
  

