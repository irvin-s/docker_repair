FROM postgres:10 AS build

# ENV PLV8_VERSION=v2.3.5

RUN apt-get update && apt-get -y install curl git glib2.0 libc++-dev libv8-dev python python-pip postgresql-server-dev-10
RUN pip install pgxnclient
RUN pgxn install plv8

FROM postgres:10 AS final

RUN apt-get update && apt-get install -y libc++-dev

COPY --from=build /usr/share/postgresql/10/extension/plcoffee* /usr/share/postgresql/10/extension/
COPY --from=build /usr/share/postgresql/10/extension/plls* /usr/share/postgresql/10/extension/
COPY --from=build /usr/share/postgresql/10/extension/plv8* /usr/share/postgresql/10/extension/
COPY --from=build /usr/lib/postgresql/10/lib/plv8*.so /usr/lib/postgresql/10/lib/
COPY --from=build /usr/lib/postgresql/10/lib/pgxs* /usr/lib/postgresql/10/lib/
COPY --from=build /usr/lib/postgresql/10/bin/pg_config /usr/lib/postgresql/10/bin/pg_config

RUN chmod -R 644 /usr/share/postgresql/10/extension/plcoffee* /usr/share/postgresql/10/extension/plls* /usr/share/postgresql/10/extension/plv8* && \
    chmod 755 /usr/lib/postgresql/10/lib/plv8*.so && \
    chmod 755 /usr/lib/postgresql/10/bin/pg_config

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD password
ENV POSTGRES_DATABASE app

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["postgres"]
