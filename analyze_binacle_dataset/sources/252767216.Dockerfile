FROM java:8-jre  
MAINTAINER Alexandre Lourenco <alexandreesl@example.com>  
  
  
VOLUME [ "/data" ]  
  
WORKDIR /data  
  
EXPOSE 8080  
ENTRYPOINT [ "java" ]  
CMD ["-?"]  

