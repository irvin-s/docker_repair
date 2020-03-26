FROM unocha/alpine-base-s6:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8 \
    PGDATA=/var/lib/pgsql

COPY run_postgres fix_data_dir /tmp/

RUN apk add --update-cache \
        postgresql \
        postgresql-client \
        postgresql-contrib \
        && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/postgres /etc/fix-attrs.d && \
    cp /tmp/fix_data_dir /etc/fix-attrs.d/01-fix-data-dir && \
    mv /tmp/run_postgres /etc/services.d/postgres/run

EXPOSE 5432

VOLUME ["/var/lib/pgsql"]
