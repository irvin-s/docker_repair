FROM beevelop/nodejs-python

MAINTAINER Maik Hummel <m@ikhummel.com>

WORKDIR /opt

ENV GH_CLIENT_ID=null \
    GH_CLIENT_SECRET=null \
    INFOSITE="http://shields.io"

RUN apt-get update && apt-get install -y pkg-config libcairo2-dev git gettext imagemagick && \
    git clone https://github.com/badges/shields && cd shields && \
    npm i

COPY secret.tpl.json ./shields/

CMD envsubst < shields/secret.tpl.json > shields/secret.json && node shields/server.js

EXPOSE 80
