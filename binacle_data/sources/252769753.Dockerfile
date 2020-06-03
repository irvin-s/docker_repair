FROM postgres:latest  
EXPOSE 5432  
COPY ami-pap-db.sql /docker-entrypoint-initdb.d/ami-pap-db.sql  

