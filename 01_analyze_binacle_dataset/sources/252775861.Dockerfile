# Dockerfile  
FROM wnameless/oracle-xe-11g  
  
ADD init.sql /docker-entrypoint-initdb.d/  

