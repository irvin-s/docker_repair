FROM ubuntu:16.04

ARG repository="deb http://repo.yandex.ru/clickhouse/deb/stable/ main/"
ARG version=18.10.3

RUN apt-get update && \
    apt-get install -y apt-transport-https tzdata && \
    mkdir -p /etc/apt/sources.list.d && \
    echo $repository | tee /etc/apt/sources.list.d/clickhouse.list && \
    apt-get update && \
    apt-get install --allow-unauthenticated -y clickhouse-server-common=$version clickhouse-server-base=$version clickhouse-client=$version && \
    rm -rf /var/lib/apt/lists/* /var/cache/debconf && \
    apt-get clean

RUN sed -i 's,<listen_host>127.0.0.1</listen_host>,<listen_host>0.0.0.0</listen_host>,' /etc/clickhouse-server/config.xml && \
    sed -i 's,<listen_host>::1</listen_host>,,' /etc/clickhouse-server/config.xml
RUN mkdir /nonexistent && \
    chown -R clickhouse /etc/clickhouse-server/ && \
    chown -R clickhouse /nonexistent

USER clickhouse
EXPOSE 9000 8123 9009
VOLUME /var/lib/clickhouse
ENV CLICKHOUSE_CONFIG /etc/clickhouse-server/config.xml

ENTRYPOINT exec /usr/bin/clickhouse-server --config=${CLICKHOUSE_CONFIG}
