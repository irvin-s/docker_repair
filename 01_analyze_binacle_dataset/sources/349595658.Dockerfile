FROM mysql:5.7.9

ADD 00-create-script.sql /docker-entrypoint-initdb.d/00-create-script.sql
ADD 01-load-script.sql /docker-entrypoint-initdb.d/01-load-script.sql

ENV MYSQL_ROOT_PASSWORD admin123
ENV MYSQL_DATABASE labdb
ENV MYSQL_USER mysql
ENV MYSQL_PASSWORD mysql

RUN /entrypoint.sh mysqld & sleep 30 && killall mysqld
