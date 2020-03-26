# Redis 4.0-rc2

FROM alpine:3.5
MAINTAINER Adrian B. Danieli "https://github.com/sickp"

EXPOSE 6379
ENTRYPOINT ["/entrypoint.sh"]
CMD ["redis-server", "/etc/redis.conf"]
VOLUME ["/data"]
WORKDIR /data
COPY rootfs /

RUN build_packages="build-base linux-headers openssl" \
  && apk --update add ${build_packages} \
  && wget -O /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 \
  && chmod +x /usr/local/bin/gosu \
  && cd /tmp \
  && wget https://github.com/antirez/redis/archive/4.0-rc2.tar.gz \
  && tar xzf 4.0-rc2.tar.gz \
  && cd /tmp/redis-4.0-rc2 \
  && make \
  && make install \
  && cp redis.conf /etc/redis.conf \
  && sed -i -e 's/bind 127.0.0.1/bind 0.0.0.0/' /etc/redis.conf \
  && adduser -D redis \
  && rm -rf /tmp/* \
  && apk del ${build_packages} \
  && rm -rf /var/cache/apk/*
