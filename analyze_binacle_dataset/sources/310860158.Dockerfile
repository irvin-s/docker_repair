FROM postgres:9.6

ENV POSTGRES_PASSWORD 'secret'
ENV POSTGRES_USER 'url'
ENV POSTGRES_DB 'redirects'

ADD schema.sql /docker-entrypoint-initdb.d/schema.sql

VOLUME /tmp/pg /var/lib/postgres/data

EXPOSE 5432
