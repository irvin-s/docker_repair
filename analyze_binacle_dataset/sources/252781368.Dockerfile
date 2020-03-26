FROM postgres:9.6  
MAINTAINER Bosse Andersson  
  
COPY init_db.sh /docker-entrypoint-initdb.d  
RUN chmod 755 /docker-entrypoint-initdb.d/init_db.sh  

