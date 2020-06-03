FROM postgres:9.5.11  
  
COPY init.sql _updateConfig.sh /docker-entrypoint-initdb.d/

