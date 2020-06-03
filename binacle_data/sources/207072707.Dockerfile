FROM unocha/alpine-jdk:8

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Thanks to Anastas Dancha "anapsix@random.io"

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

ENV SOLR_VERSION=$VERSION \
    SOLR=solr-$VERSION \
    JDBC_MYSQL_VERSION=5.1.40 \
    JDBC_PSQL_VERSION=9.4.1207

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="alpine-solr" \
      org.label-schema.description="This service provides a stand-alone solr platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.4" \
      info.humanitarianresponse.solr=$VERSION

COPY init-demo-core.sh run-solr /

RUN apk add --update-cache \
        bash \
        curl && \
    cd /tmp && \
    echo "Getting solr $VERSION" >&2 && \
    curl -sSL http://archive.apache.org/dist/lucene/solr/$VERSION/$SOLR.tgz -o /tmp/$SOLR.tgz && \
    curl -sSL http://archive.apache.org/dist/lucene/solr/$VERSION/$SOLR.tgz.sha1 -o /tmp/$SOLR.tgz.sha1 && \
    echo "Checking solr $VERSION checksum" >&2 && \
    sha1sum -c $SOLR.tgz.sha1 && \
    mkdir -p /srv && \
    gzip -dc /tmp/$SOLR.tgz | tar -C /srv -x && \
    ln -sf /srv/$SOLR /srv/solr && \
    mkdir -p /srv/solr/dist && \
    echo "Getting PSQL JDBC" >&2 && \
    curl -sSL http://jdbc.postgresql.org/download/postgresql-$JDBC_PSQL_VERSION.jar -o /srv/solr/dist/postgresql-$JDBC_PSQL_VERSION.jar && \
    echo "Getting MYSQL JDBC" >&2 && \
    curl -sSL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz -o /tmp/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz && \
    echo mysql-connector-java-$JDBC_MYSQL_VERSION/mysql-connector-java-$JDBC_MYSQL_VERSION-bin.jar > /tmp/include && \
    gzip -dc /tmp/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz | tar -x -T /tmp/include > /srv/solr/dist/mysql-connector-java-$JDBC_MYSQL_VERSION-bin.jar && \
    echo "Cleaning up.." >&2 && \
    apk del curl || true && \
    rm -rf /tmp/* /var/cache/apk/* && \
    mkdir /etc/services.d/solr && \
    mv /run-solr /etc/services.d/solr/run && \
    sed -i 's/INFO/WARN/' /srv/solr/server/resources/log4j.properties && \
    chmod +x /init-demo-core.sh

EXPOSE 8983

WORKDIR /srv/solr

# You need to map the index / data volume from the host.
# This should be inside /srv/solr/server/solr/CORE_NAME
# Logs go into /srv/solr/server/logs.
