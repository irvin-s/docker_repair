FROM evild/alpine-nodejs:lts

MAINTAINER Kriegslustig <npm@ls7.ch>

EXPOSE 80

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /data

# Mac OS requires this for files to be writable
RUN mkdir /data
RUN addgroup staff
RUN adduser -u 1000 -G staff -D rss-o-bot

RUN npm i -g rss-o-bot
RUN npm i -g rss-o-bot-telegram
RUN npm i -g rss-o-bot-email

VOLUME '/data'

CMD ['rss-o-bot']

