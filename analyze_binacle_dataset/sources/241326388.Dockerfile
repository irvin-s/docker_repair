# CoreOS/Clair v2.0 with PostgreSQL
#
# docker run --rm -p 6060:6060 supinf/clair:2.0-with-db
# docker run --rm -p 6060:6060 -p 6061:6061 -p 5432:5432 supinf/clair:2.0-with-db
# @see https://github.com/coreos/clair/blob/master/config.yaml.sample
# with Klar: CLAIR_ADDR=localhost CLAIR_OUTPUT=Low CLAIR_THRESHOLD=10 klar golang:1.9.0-alpine

FROM supinf/clair:2.0

ENV S6_VERSION=v1.22.1.0 \
    S6_LOGGING=1

# Install s6-overlay for running multiple processes in a container
RUN apk --no-cache add --virtual build-deps curl gpgme \
    && s6_dl=https://github.com/just-containers/s6-overlay/releases/download \
    && s6_tar=s6-overlay-amd64.tar.gz \
    && curl --location --silent --show-error -O "${s6_dl}/${S6_VERSION}/${s6_tar}" \
    && curl --location --silent --show-error -O "${s6_dl}/${S6_VERSION}/${s6_tar}.sig" \
    && curl --location --silent --show-error https://keybase.io/justcontainers/key.asc | gpg --import \
    && gpg --verify ${s6_tar}.sig ${s6_tar} \
    && tar xzf ${s6_tar} -C / \
    && apk del --purge -r build-deps \
    && rm -rf ${s6_tar} ${s6_tar}.sig /var/cache/apk

# Install PostgreSQL v10.5
RUN apk --no-cache add postgresql postgresql-contrib \
    && mkdir -p /usr/local/pgsql /run/postgresql \
    && chown postgres /usr/local/pgsql /run/postgresql \
    && su postgres -c "initdb -D /usr/local/pgsql/data" \
    && echo "host  all  postgres  0.0.0.0/0  trust" > /usr/local/pgsql/data/pg_hba.conf \
    && echo "listen_addresses='*'" >> /usr/local/pgsql/data/postgresql.conf \
    && echo "stats_temp_directory='/tmp'" >> /usr/local/pgsql/data/postgresql.conf \
    && rm -rf /var/cache/apk

# Configure user services with /etc/services.d/
RUN mkdir -p /etc/services.d/postgres /var/lib/postgresql/data \
    && echo "#!/usr/bin/with-contenv sh" > /etc/services.d/postgres/run \
    && echo "s6-setuidgid postgres postgres -D /usr/local/pgsql/data" >> /etc/services.d/postgres/run

EXPOSE 6060 6061 5432

ADD config.yaml /etc/clair/

ENTRYPOINT ["/init"]
CMD ["sh", "-c", "sleep 3 && /clair"]
