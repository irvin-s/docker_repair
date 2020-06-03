FROM redis:3-alpine  
  
COPY docker-healthcheck /usr/local/bin/  
  
HEALTHCHECK CMD ["docker-healthcheck"]  

