FROM etna/drone-php7  
  
RUN apt-get update  
RUN apt-get install -y nginx-extras  

