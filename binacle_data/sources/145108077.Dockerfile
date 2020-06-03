FROM postgres:9.6.3
COPY initdb.d /docker-entrypoint-initdb.d
