FROM mysql:5.7
COPY mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf
ENV MYSQL_ROOT_PASSWORD=12345678
ENV MYSQL_PASSWORD=12345678
ENV MYSQL_USER=IdentityServer
ENV MYSQL_DATABASE=IdentityServer
EXPOSE 3306