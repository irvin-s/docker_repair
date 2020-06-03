FROM golang:onbuild  
EXPOSE 8080  
ADD docker-entrypoint.sh /usr/local/bin  
RUN chmod +x /usr/local/bin/docker-entrypoint.sh  
  
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]  
  

