FROM golang:1.6-onbuild

MAINTAINER Magdy Salem <magdy.salem@emc.com>

RUN apt-get update
RUN apt-get install -y \
    metapixel\
    imagemagick

ADD . /go/src/engine


