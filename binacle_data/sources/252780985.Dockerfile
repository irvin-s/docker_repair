FROM debian:jessie  
  
COPY install.sh /usr/bin/install.sh  
  
RUN chmod +x /usr/bin/install.sh && bash /usr/bin/install.sh  

