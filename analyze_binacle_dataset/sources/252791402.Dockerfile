FROM mysql:5.7  
COPY $PWD/database.sql /docker-entrypoint-initdb.d

