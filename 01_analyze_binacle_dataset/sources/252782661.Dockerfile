FROM mysql:5.6  
COPY 1-SCHEMA.sql /docker-entrypoint-initdb.d/  
COPY 2-PRIVILEGES.sql /docker-entrypoint-initdb.d/  
COPY 3-ENTRIES.sql /docker-entrypoint-initdb.d/

