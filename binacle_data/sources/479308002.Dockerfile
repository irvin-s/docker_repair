FROM mono:3.12.0

MAINTAINER Matt Fellows <matt.fellows@onegeek.com.au>

RUN apt-get update
RUN apt-get install -y binutils gcc
RUN mkdir -p /usr/src/app/source /usr/src/app/build
WORKDIR /usr/src/app/source
ONBUILD COPY . /usr/src/app/source
ONBUILD RUN /usr/src/app/source/build-app.sh
ONBUILD WORKDIR /usr/src/app/build