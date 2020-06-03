# This image  minimal redis image based on https://hub.docker.com/r/nhoag/redis/

# Pull base image.
FROM rounds/10m-base

MAINTAINER Aviv Laufer, aviv@rounds.com

ENV REDIS_VERSION 3.0.4
ENV REDIS_DIR redis-${REDIS_VERSION}
ENV REDIS_ARCHIVE ${REDIS_DIR}.tar.gz
ENV REDIS_URL http://download.redis.io/releases/${REDIS_ARCHIVE}

WORKDIR /tmp

RUN apt-get update && \
  apt-get install -y build-essential wget && \
  wget -q ${REDIS_URL} && \
  wget -q https://raw.githubusercontent.com/antirez/redis-hashes/master/README && \
  cat README | grep ${REDIS_ARCHIVE} | awk '{print $4"  "$2}' | shasum -c && \
  tar xzf ${REDIS_ARCHIVE} && \
  cd ${REDIS_DIR} && \
  make && make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && cp -f *.conf /etc/redis && \
  rm -rf /tmp/${REDIS_DIR}* /tmp/README /var/lib/apt/lists/* && \
  sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf

VOLUME ["/data"]

WORKDIR /data

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf"]
