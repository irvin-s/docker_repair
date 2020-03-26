# vim:set ft=dockerfile:
# https://github.com/docker-library/postgres/blob/master/9.6/alpine/Dockerfile
FROM alpine:3.5

ENV LANG en_US.utf8

RUN apk --update --update-cache add \
	postgresql \
	postgresql-client \
	bash \
	su-exec \
	&& rm -rf /var/cache/apk/*

RUN mkdir /docker-entrypoint-initdb.d
ENV PG_MAJOR 9.6
ENV PG_VERSION 9.6.2

RUN sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /usr/share/postgresql/postgresql.conf.sample

RUN mkdir -p /var/run/postgresql && chown -R postgres:postgres /var/run/postgresql && chmod g+s /var/run/postgresql
ENV PGDATA /var/lib/postgresql/data
RUN mkdir -p "$PGDATA" && chown -R postgres:postgres "$PGDATA" && chmod 777 "$PGDATA" # this 777 will be replaced by 700 at runtime (allows semi-arbitrary "--user" values)

COPY docker-entrypoint.sh /usr/local/bin/
RUN chown -R postgres:postgres /usr/local/bin/docker-entrypoint.sh && chmod 755 /usr/local/bin/docker-entrypoint.sh
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat

COPY postgres_cleanup_wal.sh usr/local/bin/
RUN chown -R postgres:postgres /usr/local/bin/postgres_cleanup_wal.sh && chmod 755 /usr/local/bin/postgres_cleanup_wal.sh

COPY *.sql /docker-entrypoint-initdb.d/

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
