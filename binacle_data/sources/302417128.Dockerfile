FROM postgres:9.5

ENV PGDATA /var/lib/postgresql/data/pgdata

COPY postgres.conf /configs/

ENV POSTGRES_DB parrot

VOLUME ["/var/log/postgresql", "/var/lib/postgresql/data/pgdata"]

CMD ["postgres", "-c", "config_file=/configs/postgres.conf"]