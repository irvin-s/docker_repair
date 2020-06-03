FROM postgres:9-alpine  
  
COPY init_psql.sh /docker-entrypoint-initdb.d/init_psql.sh  

