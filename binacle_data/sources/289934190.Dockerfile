FROM mariadb:10.3

COPY mariadb/init.sh /docker-entrypoint-initdb.d/
COPY mariadb/entrypoint.sh /usr/local/bin/master-slave-entrypoint.sh

ENTRYPOINT ["master-slave-entrypoint.sh"]

CMD ["mysqld"]
