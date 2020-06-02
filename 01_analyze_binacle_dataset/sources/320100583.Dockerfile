FROM ncc0706/alpine-sshd

MAINTAINER niuyuxian <"ncc0706@gmail.com">

WORKDIR /app

RUN apk --no-cache --update add --virtual .build-deps \
	make \
	gcc \
	linux-headers \
	musl-dev \
	&& cd /app \ 
	&& wget http://download.redis.io/releases/redis-3.2.8.tar.gz \
	&& tar -zxvf redis-3.2.8.tar.gz \
	&& rm redis-3.2.8.tar.gz \
	&& mv redis-3.2.8 redis \
	&& cd redis \
	&& make && make install \
	&& mkdir -p /etc/redis \
	&& cp redis.conf /etc/redis \
	&& sed -i '128s/daemonize no/daemonize yes/' /etc/redis/redis.conf \
	&& sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis/redis.conf \
	&& mkdir /data \
	&& addgroup -S redis && adduser -S -G redis redis \
	&& chown redis:redis /data \
	&& rm -rf /var/cache/apk/* /tmp/* \
	&& apk del .build-deps

ADD supervisord.conf /etc/supervisord.conf

VOLUME /data

EXPOSE 6379

ENTRYPOINT ["/usr/bin/supervisord"]









