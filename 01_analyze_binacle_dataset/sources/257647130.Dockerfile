FROM ubuntu:trusty
MAINTAINER Daniel Perez <daniel.perez3@hpe.com>, Da-Sheng Jian <da-sheng.jian@hpe.com>
ENV REFRESHED_AT 2016-10-14

ENV http_proxy= https_proxy=

RUN apt-get update && apt-get install -y build-essential curl

RUN apt-get install -y redis-server
ADD redis/redis.conf /etc/redis/

RUN mkdir -p /log/redis && chown -R redis:redis /log/redis
RUN mkdir -p /data/redis && chown -R redis:redis /data/redis

VOLUME ["/log/redis", "/data/redis"]

RUN apt-get install -y supervisor
ADD supervisor/ /etc/supervisor/conf.d/
VOLUME ["/log/supervisor"]
CMD exec supervisord -n

RUN useradd -d /opt/hubot -m -s /bin/bash -U hubot
RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash - && apt-get install -y nodejs
RUN npm install -g yo generator-hubot
RUN mkdir -p /log/hubot && chown hubot:hubot /log/hubot
VOLUME ["/log/hubot"]
EXPOSE 5601

USER    hubot
WORKDIR /opt/hubot
RUN yo hubot --owner="DOES" --name="bot" --description="a simple helpful robot" --adapter="flowdock" --defaults


RUN mkdir -p /opt/hubot/config
ADD hubot/*.json /opt/hubot/
ADD hubot/hubot.env /opt/hubot/
ADD hubot/config/*.json /opt/hubot/config
ADD hubot/scripts/ /opt/hubot/scripts/

ENV http_proxy= https_proxy=

RUN npm install

USER root
WORKDIR /
