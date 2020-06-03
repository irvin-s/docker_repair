FROM alpine:latest
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

ENV LANG C.UTF-8
ENV LC_ALL C
ENV GOSU_VERSION 1.10

RUN addgroup -g 1000 wc && adduser -u 1000 -G wc -D wc
RUN apk add --update \
		bash \
		ca-certificates \
		curl \
		openssl \
		perl \
		python \
		sudo \
		tcl \
		tini \
		weechat \
		wget \
		&& \
		rm -rf /var/cache/apk/*

RUN curl -sL -o /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 \
		&& \
		chmod 755 /usr/local/bin/gosu

COPY weechat.sh /usr/local/bin/

ENTRYPOINT ["/sbin/tini", "-g", "--", "/usr/local/bin/weechat.sh"]
