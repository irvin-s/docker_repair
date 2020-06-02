FROM postgres:9.5.4  
MAINTAINER Colin David Scott <@AbstractCode>  
  
COPY database_init.sql /docker-entrypoint-initdb.d/database_init.sql  

