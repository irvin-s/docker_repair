FROM mysql:5.7.22  
COPY docker-healthcheck /usr/local/bin  
  
HEALTHCHECK CMD ["docker-healthcheck"]  

