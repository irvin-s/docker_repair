FROM dveeden/mysqlcluster74:base
MAINTAINER Daniël van Eeden <docker@myname.nl>

RUN mkdir -p /usr/local/mysql/mysql-cluster
RUN mkdir -p /var/lib/mysql-cluster
ADD config.ini /usr/local/mysql/mysql-cluster/

EXPOSE 1186

ENTRYPOINT /opt/mysql/bin/ndb_mgmd -f /usr/local/mysql/mysql-cluster/config.ini --initial --nodaemon
