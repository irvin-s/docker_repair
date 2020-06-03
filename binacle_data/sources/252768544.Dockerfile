FROM postgres  
ADD fix-acl.sh /docker-entrypoint-initdb.d/  
  

