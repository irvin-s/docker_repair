FROM node:0.10.32
MAINTAINER Jake Gaylor <jhgaylor@gmail.com>

ADD . /lolhubot
WORKDIR /lolhubot

RUN npm install

ENV HUBOT_NAME "StatBot"
ENV HUBOT_LOG_LEVEL "info"

# configure hubot XMPP
ENV HUBOT_ADAPTER xmpp
ENV HUBOT_XMPP_HOST chat.na2.lol.riotgames.com
ENV HUBOT_XMPP_PORT 5223
ENV HUBOT_XMPP_LEGACYSSL 1
ENV HUBOT_XMPP_ROOMS ""

cmd bin/hubot
