FROM lyapi-postgres:latest
MAINTAINER Lien Chiang <xsoameix@gmail.com>

VOLUME ["/var/lib/postgresql", "/var/log/postgresql", "/etc/postgresql"]

CMD bash
