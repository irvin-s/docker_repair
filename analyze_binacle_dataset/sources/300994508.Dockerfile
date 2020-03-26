FROM postgres:9.6-alpine
ADD init.sql /docker-entrypoint-initdb.d/