FROM rabbitmq:3-management-alpine  
  
COPY docker-healthcheck /usr/local/bin/  
  
HEALTHCHECK CMD ["docker-healthcheck"]  

