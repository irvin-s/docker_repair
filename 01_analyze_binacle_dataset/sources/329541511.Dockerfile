# base image
FROM postgres:10.4

# run create.sql on init
COPY create.sql /docker-entrypoint-initdb.d
