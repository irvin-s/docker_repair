FROM mysql:5.5  
# 2.18.0  
ENV MYSQL_ROOT_PASSWORD toor  
ENV MYSQL_USER arr  
ENV MYSQL_PASSWORD arr  
ENV MYSQL_DATABASE arrdb  
  
COPY arrdb.mysql /docker-entrypoint-initdb.d/arrdb.sql  
  
EXPOSE 3306  

