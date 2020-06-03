FROM unocha/alpine-jdk:8

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV SOLR_VERSION=4.10.4 \
    SOLR=solr-4.10.4 \
    JDBC_MYSQL_VERSION=5.1.38 \
    JDBC_PSQL_VERSION=9.4.1207 \
    SOLR_HEAP_SIZE=512m

COPY run-solr /

RUN apk add --update \
        bash \
        curl && \
    cd /tmp && \
    echo "getting solr $SOLR_VERSION" >&2 && \
    curl -sSL http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$SOLR.tgz -o /tmp/$SOLR.tgz && \
    mkdir -p /srv && \
    gzip -dc /tmp/$SOLR.tgz | tar -C /srv -x && \
    mv /srv/$SOLR /srv/solr && \
    echo "getting PSQL JDBC" >&2 && \
    curl -sSL http://jdbc.postgresql.org/download/postgresql-$JDBC_PSQL_VERSION.jar -o /srv/solr/dist/postgresql-$JDBC_PSQL_VERSION.jar && \
    echo "getting MYSQL JDBC" >&2 && \
    curl -sSL http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz -o /tmp/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz && \
    echo mysql-connector-java-$JDBC_MYSQL_VERSION/mysql-connector-java-$JDBC_MYSQL_VERSION-bin.jar > /tmp/include && \
    gzip -dc /tmp/mysql-connector-java-$JDBC_MYSQL_VERSION.tar.gz | tar -x -T /tmp/include > /srv/solr/dist/mysql-connector-java-$JDBC_MYSQL_VERSION-bin.jar && \
    echo "cleaning up.." >&2 && \
    apk del curl || true && \
    rm -rf /tmp/* /var/cache/apk/* && \
    echo "setting log level to warn.." && \
    sed -i 's/INFO/WARN/' /srv/solr/example/resources/log4j.properties && \
    echo "creating solr service.." && \
    mkdir /etc/services.d/solr && \
    mv /run-solr /etc/services.d/solr/run

VOLUME ["/srv/solr/example/solr/collection1"]

WORKDIR /srv/solr

EXPOSE 8983
