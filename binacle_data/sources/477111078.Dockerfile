# This tag use ubuntu 14.04
FROM redis:alpine

#MAINTAINER Johan Andersson <Grokzen@gmail.com>
MAINTAINER Eloy Coto <eloy.coto@gmail.com>

# Some Environment Variables
ENV HOME /root
RUN apk update && apk --update add ruby ruby-rdoc ruby-irb supervisor git
RUN /usr/bin/gem install redis
RUN git clone -b 3.0.6 https://github.com/antirez/redis.git /redis

# Build redis from source
#RUN (cd /redis && make)

RUN mkdir /redis-data && \
    mkdir /redis-data/7000 && \
    mkdir /redis-data/7001 && \
    mkdir /redis-data/7002 && \
    mkdir /redis-data/7003 && \
    mkdir /redis-data/7004 && \
    mkdir /redis-data/7005 && \
    mkdir /redis-data/7006 && \
    mkdir /redis-data/7007 && \
    mkdir -p /var/log/supervisor/ && \
    mkdir -p /etc/supervisor.d

# Add all config files for all clusters
ADD ./docker-data/redis-conf /redis-conf

# Add supervisord configuration
ADD ./docker-data/supervisord.conf /etc/supervisor.d/supervisord.ini

ADD ./docker-data/start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 7000 7001 7002 7003 7004 7005 7006 7007

CMD ["/bin/sh", "/start.sh"]
ENTRYPOINT ["/bin/sh", "/start.sh"]
