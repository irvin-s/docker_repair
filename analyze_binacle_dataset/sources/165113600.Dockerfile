FROM postgres:10.3

ENV POSTGRES_PASSWORD omp

COPY ./init.sh /docker-entrypoint-initdb.d/
COPY ./schema /schema
