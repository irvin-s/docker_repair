FROM postgres:9.6.5-alpine  
  
ADD init.sh /docker-entrypoint-initdb.d/  
RUN chmod 755 /docker-entrypoint-initdb.d/init.sh

