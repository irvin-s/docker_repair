FROM mariadb

COPY dump.sql /docker-entrypoint-initdb.d
