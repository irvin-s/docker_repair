FROM debian:jessie

MAINTAINER Peter Szalatnay <theotherland@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive PERCONA_MAJOR=57

RUN \
    groupadd -r mysql && useradd -r -g mysql mysql \
    && apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 8507EFA5 \
    && echo 'deb http://repo.percona.com/apt jessie main' > /etc/apt/sources.list.d/percona.list \
    && apt-get update && apt-get install -y \
        percona-xtradb-cluster-${PERCONA_MAJOR} \
        curl \
        sysbench \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/mysql \
    && mkdir /var/lib/mysql \
    && sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf \
    && echo 'skip-host-cache\nskip-name-resolve' | awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' /etc/mysql/my.cnf > /tmp/my.cnf \
    && mv /tmp/my.cnf /etc/mysql/my.cnf \
    && mkdir -p /opt/rancher \
    && curl -SL https://github.com/cloudnautique/giddyup/releases/download/v0.14.0/giddyup -o /opt/rancher/giddyup \
    && chmod +x /opt/rancher/giddyup

COPY ./start_pxc /opt/rancher

COPY ./docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

VOLUME ["/var/lib/mysql", "/run/mysqld", "/etc/mysql/conf.d"]

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3306 4444 4567 4568

CMD ["mysqld"]