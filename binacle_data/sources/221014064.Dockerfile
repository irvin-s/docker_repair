FROM ubuntu:trusty

MAINTAINER Sergey Rudachenko <rs@roistat.com>

RUN echo "deb http://repo.yandex.ru/clickhouse/trusty/ dists/stable/main/binary-amd64/" \
    > /etc/apt/sources.list.d/clickhouse.list

RUN apt-get update

RUN apt-get install -y --allow-unauthenticated \
    clickhouse-server-common \
    clickhouse-client

CMD ["clickhouse-server", "--config-file=/etc/clickhouse-server/config.xml"]

EXPOSE 9000 8123
