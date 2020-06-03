FROM postgres:9.5

COPY hello.sql /docker-entrypoint-initdb.d/
