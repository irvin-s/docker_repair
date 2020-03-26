FROM gliderlabs/alpine:3.1
RUN apk update
RUN apk upgrade
RUN apk add --upgrade tar
RUN apk add --upgrade curl
RUN apk add --update nodejs
RUN curl -Ls https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz \
  | tar xz -C
RUN apk add --update bash
RUN npm install url2img -g
