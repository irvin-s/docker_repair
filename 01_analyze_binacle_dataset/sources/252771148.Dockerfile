FROM mysql:5.7.13  
COPY initialize-database.sql /docker-entrypoint-initdb.d  

