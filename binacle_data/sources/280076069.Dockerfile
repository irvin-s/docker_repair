FROM alpine:3.8

RUN apk update && apk upgrade && \
    apk add --no-cache varnish

COPY conf/default.vcl /etc/varnish/
COPY start.sh /usr/local/bin/docker-app-start
RUN chmod +x /usr/local/bin/docker-app-start

CMD ["docker-app-start"]
