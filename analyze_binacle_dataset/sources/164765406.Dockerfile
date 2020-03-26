FROM dveeden/mysqlcluster74:base
MAINTAINER Daniël van Eeden <docker@myname.nl>

RUN mkdir -p /usr/local/mysql/data
ENTRYPOINT /opt/mysql/bin/ndbmtd --nodaemon --initial --connect-string="host=${MGM01_PORT_1186_TCP_ADDR}:1186"
