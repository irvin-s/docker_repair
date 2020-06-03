# Redis Server (gewo/redis)
FROM gewo/redis-base
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

ENV VERSION 2.6.15

RUN \
  wget http://download.redis.io/releases/redis-${VERSION}.tar.gz &&\
  tar xvfz redis-${VERSION}.tar.gz &&\
  cd redis-${VERSION} && make redis-server && cd - &&\
  mv redis-${VERSION}/src/redis-server /usr/bin &&\
  rm -rf redis-${VERSION}*
