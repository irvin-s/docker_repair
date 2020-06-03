FROM postgres:10  
COPY create-postgresql-db-with-role.sh /docker-entrypoint-initdb.d/

