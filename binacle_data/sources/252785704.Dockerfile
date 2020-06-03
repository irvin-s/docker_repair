FROM postgres:9.3  
MAINTAINER Artem Zaborskiy “artem@toptal.com"  
  
COPY docker-entrypoint-initdb.d/* /docker-entrypoint-initdb.d/  
RUN ls -la docker-entrypoint-initdb.d/  

