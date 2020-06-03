FROM debian:jessie  
  
RUN mkdir /app  
RUN mkdir /data  
RUN mkdir /var/lib/mysql  
  
VOLUME ["/app", "/data", "/var/lib/mysql"]  

