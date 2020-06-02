FROM alpine:3.7  
COPY redir /usr/local/bin  
RUN chmod +x /usr/local/bin/redir  
  
COPY docker-entrypoint.sh /usr/local/bin  
RUN chmod +x /usr/local/bin/docker-entrypoint.sh  
  
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]  

