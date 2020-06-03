### Dockerfile
#
#   See https://github.com/russmckendrick/docker

FROM russmckendrick/base:latest
MAINTAINER Russ McKendrick <russ@mckendrick.io>

ENV TERM dumb

ENV NPM_CONFIG_GLOBALCONFIG /etc/npmrc
COPY npmrc /etc/npmrc

RUN apk add --update \
	nodejs && \ 
	rm -rf /var/cache/apk/* && \
	npm -g install npm && \
    npm cache clean --force
