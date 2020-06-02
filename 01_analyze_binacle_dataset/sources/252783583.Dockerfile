# Dockerfile  
FROM wnameless/oracle-xe-11g  
  
ADD owncloud.sql /docker-entrypoint-initdb.d/  

