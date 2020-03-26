FROM janeczku/alpine-kubernetes:3.3
MAINTAINER Adrian B. Danieli "https://github.com/sickp"

ENV \
  REDIS_VERSION=3.0.7 \
  BUILD_PACKAGES="build-base linux-headers openssl" \
  RUNTIME_PACKAGES=""

RUN \
  apk --update add ${BUILD_PACKAGES} ${RUNTIME_PACKAGES} && \
  cd /tmp && \
  wget http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz && \
  tar xzf redis-${REDIS_VERSION}.tar.gz && \
  cd /tmp/redis-${REDIS_VERSION} && \
  make && \
  make install && \
  mv /usr/local/bin/redis-server /usr/local/bin/redis-server-wrapped && \
  cp redis.conf /etc/redis.conf && \
  adduser -D redis && \
  mkdir /data && \
  chown redis:redis /data && \
  rm -rf /tmp/* && \
  apk del ${BUILD_PACKAGES} && \
  rm -rf /var/cache/apk/*

VOLUME ["/data"]
WORKDIR /data

EXPOSE 6379

COPY rootfs /

# DO NOT OVERRIDE: ENTRYPOINT ["/init"]
CMD ["redis-server", "/etc/redis.conf"]
