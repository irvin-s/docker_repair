# Postgresql

FROM ubuntu:trusty
MAINTAINER Olivier Hardy "ohardy@me.com"

ADD bin /usr/bin

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen $LANG; echo "LANG=\"${LANG}\"" > /etc/default/locale; dpkg-reconfigure locales

RUN apt-get update
RUN apt-get -y install redis-server redis-tools

RUN sed -i 's@bind 127.0.0.1@bind 0.0.0.0@' /etc/redis/redis.conf
RUN sed -i 's@daemonize yes@daemonize no@' /etc/redis/redis.conf
RUN sed -i 's@daemonize yes@daemonize no@' /etc/redis/redis.conf
RUN sed -i 's@databases 16@databases 100@'  /etc/redis/redis.conf
EXPOSE 6379

CMD ["help"]

ENTRYPOINT ["manage"]
