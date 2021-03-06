FROM alpine:3.9
MAINTAINER "Peter Schiffer" <peter@rfv.sk>

RUN apk add --no-cache \
    pdns \
    pdns-backend-mysql \
    pdns-doc \
    python3 \
    mariadb-client

RUN pip3 install --no-cache-dir envtpl

ENV VERSION=4.1 \
  PDNS_guardian=yes \
  PDNS_setuid=pdns \
  PDNS_setgid=pdns \
  PDNS_launch=gmysql

EXPOSE 53 53/udp

COPY pdns.conf.tpl /
COPY docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "/usr/sbin/pdns_server" ]
