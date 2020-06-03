FROM alpine
MAINTAINER Anthony Woods awoods@raintank.io

RUN apk --update add ca-certificates

RUN mkdir -p /etc/gw
COPY scripts/config/tsdb-gw.ini /etc/gw/tsdb-gw.ini
COPY scripts/build/tsdb-gw /usr/bin/tsdb-gw
COPY scripts/entrypoint.sh /usr/bin/

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/usr/bin/tsdb-gw", "-config=/etc/gw/tsdb-gw.ini"]
