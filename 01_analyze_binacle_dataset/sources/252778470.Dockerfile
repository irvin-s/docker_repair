FROM postgres:9.5-alpine  
  
ENV AP_USER appuser  
ENV AP_PASSWORD mysecretpassword  
ENV AP_DATABASE app  
  
COPY createdb.sh /docker-entrypoint-initdb.d/  
  

