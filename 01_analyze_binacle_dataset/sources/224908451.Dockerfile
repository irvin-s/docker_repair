# Redis 3.2.0

FROM janeczku/alpine-kubernetes:3.3
MAINTAINER Adrian B. Danieli "https://github.com/sickp"

RUN build_packages="build-base linux-headers openssl" \
  && apk --update add ${build_packages} \
  && cd /tmp \
  && wget http://download.redis.io/releases/redis-3.2.0.tar.gz \
  && tar xzf redis-3.2.0.tar.gz \
  && cd /tmp/redis-3.2.0 \
  && make \
  && make install \
  && mv /usr/local/bin/redis-server /usr/local/bin/redis-server-wrapped \
  && cp redis.conf /etc/redis.conf \
  && sed -i -e 's/bind 127.0.0.1/bind 0.0.0.0/' /etc/redis.conf \
  && adduser -D redis \
  && mkdir /data \
  && chown redis:redis /data \
  && rm -rf /tmp/* \
  && apk del ${build_packages} \
  && rm -rf /var/cache/apk/*

VOLUME ["/data"]
WORKDIR /data

EXPOSE 6379

COPY rootfs /

# DO NOT OVERRIDE: ENTRYPOINT ["/init"]
CMD ["redis-server", "/etc/redis.conf"]
