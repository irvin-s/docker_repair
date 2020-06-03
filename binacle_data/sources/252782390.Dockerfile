FROM mdillon/postgis  
RUN mkdir -p /docker-entrypoint-initdb.d  
ADD create_civic.sh /docker-entrypoint-initdb.d/  
  
EXPOSE 5432  

