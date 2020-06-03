FROM mysql/mysql-server:5.7  
MAINTAINER "Devendra <dev_nalawade@yahoo.com>"  
VOLUME ["/var/log/", "/docker-entrypoint-initdb.d/"]  
  
# allow connections from Host Machine  
ENV MYSQL_ROOT_HOST=192.168.99.1  
# TODO will be moved into secrets  
ENV MYSQL_ROOT_PASSWORD=someroot  
  
ENV MYSQL_USER=passport_user  
ENV MYSQL_PASSWORD=changeit  
ENV MYSQL_DATABASE=passport_db  
  
ADD "init/bootstrap.sql" "/docker-entrypoint-initdb.d/bootstrap.sql"  

