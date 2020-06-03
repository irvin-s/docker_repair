FROM postgres:latest  
  
RUN apt-get update && apt-get install postgis -y  
  
RUN mkdir -p /docker-entrypoint-initdb.d  
  
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh  
COPY ./create_pg_trgrm_extension.sh /docker-entrypoint-initdb.d/pg_trgrm.sh

