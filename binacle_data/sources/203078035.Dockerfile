FROM node:10-alpine

RUN apk add --no-cache python git build-base curl

RUN set -xe; \
  mkdir /app; \
  chgrp node /app; \
  chown node /app;

RUN USER=node && \
    GROUP=node && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

ARG VERSION
RUN set -xe;\
    npm install -g @angular/cli@$VERSION;\
    npm cache clean --force;

WORKDIR /app
# Fixuid will fail if we set it as volume
# VOLUME /app

ENV APPNAME=hero GENERATE=true
ADD entrypoint.sh /entrypoint.sh

EXPOSE 4200
USER 1000:1000

ENV ANGULAR_VERSION=${VERSION} ANGULAR_STYLESHEET_FORMAT=css ANGULAR_ROUTING=true
ENTRYPOINT ["/entrypoint.sh"]
CMD ["ng", "serve", "--host", "0.0.0.0"]

