FROM debian:jessie

LABEL maintainer My Name <myemail@example.com>
LABEL refreshed_at 2017-03-14

COPY redis.conf /var/local

RUN apt-get update \
    && apt-get install -y redis-server \
    && mkdir -p /logs \
    && mkdir -p /db

EXPOSE 6379
VOLUME /db

WORKDIR /var/db

ENTRYPOINT ["/usr/bin/redis-server", "/var/local/redis.conf"]
