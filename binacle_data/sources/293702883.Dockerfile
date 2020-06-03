# Credits to https://github.com/abiosoft/caddy-docker
FROM alpine:3.9
MAINTAINER Kevin Minehart <kminehart@wehco.com>

ARG plugins=http.jwt,http.proxyprotocol,http.realip

RUN apk add --no-cache openssh-client git tar curl

COPY caddy-ingress-controller /caddy-ingress-controller

EXPOSE 80 443 12015

# This is where TLS certificates from acme live.
VOLUME /root/.caddy

# This will copy the generated config files to the filesystem.
COPY ./etc /etc

CMD ["/caddy-ingress-controller"]
