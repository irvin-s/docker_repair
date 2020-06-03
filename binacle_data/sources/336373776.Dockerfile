FROM mysql

COPY mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf

ENV MYSQL_ROOT_PASSWORD ies2010
ENV MYSQL_DATABASE colors
ENV MYSQL_USER color
ENV MYSQL_PASSWORD ies2010

ADD setup.sql /docker-entrypoint-initdb.d

