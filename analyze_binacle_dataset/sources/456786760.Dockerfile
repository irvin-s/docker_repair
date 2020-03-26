FROM mysql:5.6

MAINTAINER k12-MYSQL "wlfkongl@163.com"
RUN  cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN usermod -u 1000 mysql && chown mysql.mysql /var/run/mysqld/
EXPOSE 3306
VOLUME ["/opt"]
