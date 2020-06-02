FROM mysql:8.0.3

COPY ./create_schema.sql /docker-entrypoint-initdb.d/
