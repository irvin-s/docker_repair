FROM mysql:5.6

ADD init.sql /docker-entrypoint-initdb.d