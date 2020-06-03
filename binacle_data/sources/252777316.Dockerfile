FROM postgres:9-alpine  
  
LABEL version=latest  
  
COPY ./docker-entrypoint.sh /usr/local/bin  

