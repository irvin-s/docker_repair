FROM fedora  
  
COPY ./docker-gc /docker-gc  
  
VOLUME /var/lib/docker-gc  
  
CMD ["/docker-gc"]  

