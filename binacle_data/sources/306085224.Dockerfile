FROM alpine
MAINTAINER Anthony Woods awoods@raintank.io

RUN apk --no-cache --update add ca-certificates
RUN mkdir -p /etc/gw

COPY scripts/config/cortex-gw.ini /etc/gw/cortex-gw.ini
COPY build/cortex-gw /usr/bin/cortex-gw
COPY scripts/entrypoint.sh /usr/bin/

EXPOSE 80
EXPOSE 443
EXPOSE 8001

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/usr/bin/cortex-gw", "-config=/etc/gw/cortex-gw.ini"]
