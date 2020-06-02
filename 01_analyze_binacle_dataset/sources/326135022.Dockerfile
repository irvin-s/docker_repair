FROM mariadb:10.2.18

COPY my.cnf /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]

EXPOSE 3306
