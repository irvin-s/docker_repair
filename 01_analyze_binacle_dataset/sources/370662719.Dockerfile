FROM postgres:latest

COPY init-user-db.sql /docker-entrypoint-initdb.d/
