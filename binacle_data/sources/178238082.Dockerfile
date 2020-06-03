# Based on 1024/slackirc, but with tini
FROM alpine:latest
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

RUN apk add --no-cache --update nodejs-npm tini \
	&& \
	rm -rf /var/cache/apk/*
RUN npm install -g slack-irc
RUN addgroup -g 1000 slackirc && adduser -u 1000 -G slackirc -D slackirc

USER slackirc
ENV NODE_ENV development
ENV SLACK_LOG_LEVEL debug

ENTRYPOINT ["tini", "-g", "--"]
CMD ["slack-irc"]
