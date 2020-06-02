FROM postgres:9.4.7  
ENV POSTGRES_PASSWORD=test  
  
COPY ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d  

