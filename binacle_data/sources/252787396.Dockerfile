# Dockerfile  
FROM postgres:9.4  
RUN mkdir -p /tmp/psql_data/  
  
EXPOSE 5432  
COPY structure.sql /tmp/psql_data/  
COPY init_docker_postgres.sh /docker-entrypoint-initdb.d/

