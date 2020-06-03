FROM postgres:latest  
ENV POSTGRES_PASSWORD temp12345  
ADD init.sql /docker-entrypoint-initdb.d/  
  

