FROM node:9-alpine AS build
LABEL maintainer="arne@hilmann.de"

USER root

RUN echo "trigger new build"

RUN apk update && \
    apk add curl python cairo-dev pkgconf pixman-dev pango-dev g++ \
        make git php5 php5-json libpng libjpeg-turbo-dev giflib-dev && \
    rm -rf /var/cache/apk/*

RUN npm -g config set user root
RUN npm install -g canvas --build-from-source
RUN npm install -g underscore xpath xmldom express body-parser canvas-5-polyfill svgo

RUN echo ahhhh

WORKDIR /
RUN git clone https://github.com/dhobsd/asciitosvg.git
RUN curl -OL https://cdn.jsdelivr.net/gh/pshihn/rough@9be60b1e/dist/rough.js
RUN curl -OL https://github.com/ipython/xkcd-font/raw/master/xkcd-script/font/xkcd-script.ttf

RUN ln -sf /asciitosvg/a2s /usr/bin/a2s
RUN ln -sf /usr/bin/php5 /usr/bin/php
# xkcd font
RUN mkdir -p /usr/share/fonts
COPY xkcd-script.ttf /usr/share/fonts/
ENV FONTCONFIG_PATH=/etc/fonts
RUN fc-cache -v -f
RUN fc-list

RUN chmod a+rwx /asciitosvg/objects

# switch to non-root user
USER node
WORKDIR /home/node
# RUN mkdir -p .a2s/objects
RUN mkdir -p .a2s/
RUN ln -sf /asciitosvg/objects /home/node/.a2s/objects
COPY addons/* /asciitosvg/objects/

ENV NODE_PATH=/usr/local/lib/node_modules/
COPY a2sketch.webserver .
COPY rough.js.patch .
RUN cp /rough.* ./
RUN patch rough.js rough.js.patch

ENTRYPOINT ["node", "a2sketch.webserver"]
