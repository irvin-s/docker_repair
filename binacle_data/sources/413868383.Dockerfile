FROM mysql

MAINTAINER Mihai Dima <mihaizn@gmail.com>

ADD ./schema.sql /docker-entrypoint-initdb.d/schema.sql

EXPOSE 3306
