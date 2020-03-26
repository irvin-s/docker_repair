FROM amazonlinux:latest
MAINTAINER Letgo <sysops@letgo.com>

USER root

RUN yum clean all && rm -fr /var/cache/*
RUN yum install -y https://github.com/tanji/replication-manager/releases/download/1.1.2/replication-manager-1.1.2-2183c2a3.x86_64.rpm

COPY config.toml /etc/replication-manager/config.toml
ADD replication-bootstrap.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/replication-bootstrap.sh
ENTRYPOINT ["/docker-entrypoint-initdb.d/replication-bootstrap.sh"]

EXPOSE 10001 

ENTRYPOINT ["/usr/bin/replication-manager", "monitor", "--daemon"]

