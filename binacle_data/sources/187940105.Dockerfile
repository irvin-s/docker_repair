FROM node:5.7.1

RUN apt-get update \
    && apt-get install -y libmagick++-dev \
    && mkdir -p /usr/local/src/deweyserver \
    && ln /usr/lib/x86_64-linux-gnu/ImageMagick-*/bin-*/Magick++-config /usr/bin/Magick++-config

COPY . /usr/local/src/deweyserver/

RUN (cd /usr/local/src/deweyserver/ && npm install)

EXPOSE 3000

CMD node /usr/local/src/deweyserver/app.js
