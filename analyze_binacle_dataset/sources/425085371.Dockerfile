# Redis Server (gewo/redis-base)
FROM gewo/base
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

RUN mkdir /data
VOLUME ["/data"]
ADD redis.conf redis.conf
EXPOSE 6379
CMD ["/usr/bin/redis-server", "redis.conf"]
