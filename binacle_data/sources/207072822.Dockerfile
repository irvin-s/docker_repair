FROM alpine:%%UPSTREAM%%

ARG S6_VERSION=v1.21.4.0
ARG POSTGIS_VERSION=2.4.4
ARG POSTGRES_VERSION=9.6.8-r0

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="postgis" \
      org.label-schema.description="This service provides a postgresql service using postgres and postgis" \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="%%UPSTREAM%%" \
      info.humanitarianresponse.s6=$S6_VERSION \
      info.humanitarianresponse.postgis=$POSTGIS_VERSION \
      info.humanitarianresponse.postgresql=$POSTGRES_VERSION

ENV LANG=en_US.utf8 \
    PGDATA=/var/lib/pgsql \
    PG_CONFIG_FILE=/etc/pgsql/postgresql.conf \
    PGSQL_DB=testdb \
    PGSQL_USER=testuser \
    PGSQL_PASS=testpass

COPY fix_pgsql_dirs pg_hba.conf postgresql.conf recovery run_postgres /tmp/

RUN apk update && \
    apk upgrade && \
    apk add \
        curl \
        nano \
        postgresql \
        postgresql-client \
        postgresql-contrib && \
    curl -sL https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz -o /tmp/s6.tgz && \
    tar xzf /tmp/s6.tgz -C / && \
    rm -f /tmp/s6.tgz && \
    mkdir -p /etc/services.d/postgres /etc/fix-attrs.d /etc/pgsql /run/postgresql && \
    cp /tmp/fix_pgsql_dirs /etc/fix-attrs.d/ && \
    mv /tmp/run_postgres /etc/services.d/postgres/run && \
    mv /tmp/pg_hba.conf /etc/pgsql/ && \
    mv /tmp/postgresql.conf /etc/pgsql/ && \
    mv /tmp/recovery /etc/pgsql/ && \
    touch /etc/pgsql/pg_ident.conf && \
    echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --update-cache \
        postgresql-dev \
        perl \
        file \
        geos@testing \
        geos-dev@testing \
        libxml2-dev \
        gdal@testing \
        gdal-dev@testing \
        proj4@testing \
        proj4-dev@testing \
        gcc \
        make \
        libgcc \
        g++ && \
    cd /tmp && \
    wget http://download.osgeo.org/postgis/source/postgis-${POSTGIS_VERSION}.tar.gz -O - | tar -xz && \
    chown root:root -R postgis-${POSTGIS_VERSION} && \
    cd /tmp/postgis-${POSTGIS_VERSION} && \
    ./configure && \
    echo "PERL = /usr/bin/perl" >> extensions/postgis/Makefile && \
    echo "PERL = /usr/bin/perl" >> extensions/postgis_topology/Makefile && \
    make -s && \
    make -s install  && \
    cd / && \
    rm -rf /tmp/postgis-${POSTGIS_VERSION} && \
    apk del postgresql-dev perl file geos-dev \
            libxml2-dev gdal-dev proj4-dev \
            gcc make libgcc g++ && \
    rm -rf /var/cache/apk/* && \
    echo "removing useless, duplicates postgis sql files" && \
    find /usr/share/postgresql/extension \
        -iname "postgis*--2.[0-9].[0-9]--${POSTGIS_VERSION}.sql" \
        ! -iname "postgis*--2.4.4--${POSTGIS_VERSION}.psql" \
        -print \
        -delete

ENTRYPOINT ["/init"]

CMD []

EXPOSE 5432

VOLUME ["/var/lib/pgsql"]
