FROM alpine:3.6

RUN \
    apk add --no-cache collectd collectd-network

CMD collectd -f