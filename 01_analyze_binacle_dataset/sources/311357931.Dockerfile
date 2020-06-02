# From https://github.com/DSpace-Labs/dspace-dev-docker/tree/master/postgres
FROM postgres

ENV POSTGRES_DB dspace
ENV POSTGRES_USER dspace
ENV POSTGRES_PASSWORD dspace

# https://github.com/DSpace/DSpace/blob/dspace-4_x/dspace/etc/postgres/database_schema.sql
COPY database_schema.sql / 
COPY import-schema.sh /docker-entrypoint-initdb.d/