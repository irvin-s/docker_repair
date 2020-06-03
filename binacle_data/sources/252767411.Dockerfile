FROM mysql:8.0  
COPY ./sql-migrate.sh /docker-entrypoint-initdb.d  
  

