FROM alpine

ENV TERM=xterm LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV TIMEZONE US/Pacific

# https://github.com/nodejs/docker-node/issues/588
# not sure if it's paxctl -cm or paxctl -cM
RUN apk -U upgrade --available \
  && apk add \
    ca-certificates openssl wget file nano tzdata htop git cmake build-base sqlite \
    paxctl python2 nodejs \
  && update-ca-certificates \
  && paxctl -cm $(which node) \
  && paxctl -cm $(which python2) \
  && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
  && echo "${TIMEZONE}" > /etc/timezone \
  && apk del tzdata \
  && rm -f /var/cache/apk/*

RUN npm i -g grunt-cli node-gyp

WORKDIR /opt
