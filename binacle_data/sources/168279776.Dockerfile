FROM phusion/baseimage:0.9.15
MAINTAINER Cyrill Schumacher <cyrill@zookal.com>
ENV HOME /root
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common

# Install Redis.
RUN \
  cd /tmp && \
  curl -LO http://download.redis.io/redis-stable.tar.gz && \
  tar xvzf redis-stable.tar.gz && \
  cd redis-stable && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  rm -rf /tmp/redis-stable*

ADD redis-base.conf /etc/redis/
ADD redis-ses.conf /etc/redis/

RUN mkdir /etc/service/redis
ADD redis.sh /etc/service/redis/run
RUN chmod 700 /etc/service/redis/run
RUN useradd -s /usr/sbin/nologin -r -M -d /nonexistent -g users redis

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Expose ports.
EXPOSE 6380

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
