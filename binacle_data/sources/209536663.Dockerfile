FROM mysql:latest

COPY mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf

ENV MYSQL_ROOT_PASSWORD 123456
