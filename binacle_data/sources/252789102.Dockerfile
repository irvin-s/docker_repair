FROM dserban/dockersparknotebook:latest  
  
COPY install.sh /usr/bin/install.sh  
  
COPY launcher.sh /usr/bin/launcher.sh  
  
RUN chmod +x /usr/bin/*.sh && bash install.sh  

