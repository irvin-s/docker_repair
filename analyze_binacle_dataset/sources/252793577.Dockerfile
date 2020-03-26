FROM concourse/docker-image-resource  
  
ADD bin/ /bin/  
RUN chmod +x /bin/docker-compose  

