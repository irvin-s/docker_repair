FROM gliderlabs/alpine:3.2
MAINTAINER Adrian B. Danieli "https://github.com/sickp"

ENV REDIS_VERSION=3.0.5

RUN packages="build-base linux-headers openssl" && \
  apk --update add ${packages} && \
  wget -O /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 && \
  chmod +x /usr/local/bin/gosu && \
  cd /tmp && \
  wget http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz && \
  tar xzf redis-${REDIS_VERSION}.tar.gz && \
  cd /tmp/redis-${REDIS_VERSION} && \
  make && \
  make install && \
  cp redis.conf /etc/redis.conf && \
  adduser -D redis && \
  mkdir /data && \
  chown redis:redis /data && \
  rm -rf /tmp/* && \
  apk del ${packages} && \
  rm -rf /var/cache/apk/*

VOLUME ["/data"]
WORKDIR /data

EXPOSE 6379

COPY /entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
