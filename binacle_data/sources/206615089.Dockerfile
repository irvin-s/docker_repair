FROM alpine:latest
MAINTAINER Patrik Votoček <patrik@votocek.cz>

RUN apk --update --no-cache upgrade && \
    apk --update --no-cache add build-base imagemagick nodejs nodejs-dev git openssh \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ && \
    npm install -g -q gulp yarn

CMD "node"
