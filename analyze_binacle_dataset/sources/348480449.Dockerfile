FROM redis:latest

MAINTAINER Haydar KÜLEKCİ <haydarkulekci@gmail.com>

#COPY redis.conf /usr/local/etc/redis/redis.conf

VOLUME /data

EXPOSE 6379

CMD ["redis-server"]
