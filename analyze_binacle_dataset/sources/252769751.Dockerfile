FROM postgres:alpine  
COPY ami-media-db.sql /docker-entrypoint-initdb.d/ami-media-db.sql  

