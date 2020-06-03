FROM postgres:9.6
ADD audit.sql /docker-entrypoint-initdb.d/
