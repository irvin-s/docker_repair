FROM mysql:5.7  
MAINTAINER bingo <bingov5@icloud.com>  
  
ENV MYSQL_RANDOM_ROOT_PASSWORD yes  
ENV LC_ALL en_US.UTF-8  
ENV TZ Asia/Shanghai  
  
COPY ./conf/mysql.cnf /etc/mysql/conf.d/mysql.cnf  
COPY ./conf/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf  
COPY ./deploy/deploy.sql /docker-entrypoint-initdb.d/deploy.sql

