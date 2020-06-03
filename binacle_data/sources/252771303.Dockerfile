FROM mysql/mysql-server:5.7  
COPY 01-xavier-schema.sql /docker-entrypoint-initdb.d/  

