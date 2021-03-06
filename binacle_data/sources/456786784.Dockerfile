FROM redis:3.0.7

MAINTAINER k12-REDIS "wlfkongl@163.com"


RUN  cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN  chown -R redis:redis /data
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

VOLUME ["/data1"]
EXPOSE 6379


