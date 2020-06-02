FROM benjspriggs/docker-stretch-dev:latest  
  
RUN apt-get update  
RUN apt-get install -y \  
sbcl  
USER dev  

