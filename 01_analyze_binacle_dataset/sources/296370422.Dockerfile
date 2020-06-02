FROM postgres:9.5.1

ENV PGDATA /var/lib/postgresql/data/pgdata

COPY configs/* /configs/

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD ["postgres", "-c", "config_file=/configs/1gb-ram.conf"]