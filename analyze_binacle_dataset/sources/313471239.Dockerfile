FROM golang:alpine as build
RUN apk add --no-cache make bash git sqlite-libs sqlite-dev build-base
WORKDIR /go/src/github.com/jonathanfoster/digitox/
COPY . .
RUN make dep-build && GOOS=linux GOARCH=amd64 make build

FROM alpine:latest

RUN apk add --no-cache squid incron && \
    mkdir -p /etc/digitox && \
    echo "" > /etc/digitox/blocklist && \
    echo "root" > /etc/incron.allow && \
    echo "/etc/digitox/blocklist IN_MODIFY /usr/sbin/squid -k reconfigure" > /var/spool/incron/root && \
    echo "/etc/digitox/passwd IN_MODIFY /usr/sbin/squid -k reconfigure" >> /var/spool/incron/root

COPY --from=build /go/src/github.com/jonathanfoster/digitox/bin/digitox-apiserver /usr/local/bin/
COPY squid.conf /etc/squid/
COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3128 8080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
