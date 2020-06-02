FROM postgres:9-alpine

COPY init.sql /docker-entrypoint-initdb.d/10-init.sql
