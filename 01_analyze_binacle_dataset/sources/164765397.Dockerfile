FROM dveeden/mysqlcluster74:base
MAINTAINER Daniël van Eeden <docker@myname.nl>

RUN mkdir -p /usr/local/mysql/mysql-cluster
RUN mkdir -p /var/lib/mysql-cluster

ENTRYPOINT /opt/mysql/bin/ndb_mgm $MGM01_PORT_1186_TCP_ADDR
