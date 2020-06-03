FROM nimmis/alpine:3.4
MAINTAINER BlackGlory <woshenmedoubuzhidao@blackglory.me>

RUN apk update && apk upgrade && \
    apk add curl && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /tmp/caddy \
 && curl -sL -o /tmp/caddy/caddy_linux_amd64.tar.gz "https://caddyserver.com/download/build?os=linux&arch=amd64" \
 && tar -zxf /tmp/caddy/caddy_linux_amd64.tar.gz -C /tmp/caddy \
 && mv /tmp/caddy/caddy /usr/bin/ \
 && chmod +x /usr/bin/caddy \
 && rm -rf /tmp/caddy

ENV DOCKER_GEN_VERSION 0.4.3
ENV CADDY_OPTIONS ""

RUN curl -sL -o docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

RUN printf ":80\nproxy / caddyserver.com" > /etc/Caddyfile

ADD etc /etc

ENV DOCKER_HOST unix:///tmp/docker.sock
