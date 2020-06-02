# Mysql 5.5 image  
FROM mysql:5.5  
  
MAINTAINER Andre Nascimento <andreluiznsilva@gmail.com>  
  
ENV MYSQL_ROOT_PASSWORD root*123  
ENV MYSQL_DATABASE default  
ENV MYSQL_USER mysql  
ENV MYSQL_PASSWORD mysql*123  
  
EXPOSE 3306  
  
WORKDIR /usr/local/mysql

