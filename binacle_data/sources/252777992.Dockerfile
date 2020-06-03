FROM crux  
  
VOLUME /ssl  
  
ENV DOMAIN localhost  
  
ENTRYPOINT ["/entrypoint"]  
  
COPY entrypoint /entrypoint  

