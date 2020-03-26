FROM postgres  
EXPOSE 5432  
ADD run.sh /docker-entrypoint-initdb.d/init-user-db.sh  

