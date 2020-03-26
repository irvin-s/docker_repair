FROM golang:1.6  
ADD docker-entrypoint.sh /  
RUN chmod +x /docker-entrypoint.sh  
  
EXPOSE 3999  
WORKDIR $GOPATH  
  
CMD ["/docker-entrypoint.sh"]  

