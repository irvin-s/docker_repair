FROM postgres:9.4  
ADD init-database.sh /docker-entrypoint-initdb.d/  
  
ADD db.pgdump.tar.gz /tmp/  

