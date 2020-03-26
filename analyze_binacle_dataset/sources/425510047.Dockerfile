FROM node
MAINTAINER Benjamin Chodoroff <bc@thermitic.net>

RUN echo deb http://ftp.fr.debian.org/debian/ jessie main contrib non-free > /etc/apt/source.list

RUN apt-get update -y

RUN apt-get install -y \
    python2.7 python-pip \
    libfreetype6 libfontconfig

RUN mkdir /data

ADD ./package.json /data/package.json

RUN cd /data && npm install

ADD . /data/

CMD node /data/server.js
