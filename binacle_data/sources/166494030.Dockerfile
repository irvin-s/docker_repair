FROM smartentry/alpine:3.5-0.3.15

MAINTAINER Yifan Gao <docker@yfgao.com>

ADD . /opt/monitor

ENV ASSETS_DIR=/opt/monitor/.docker

RUN smartentry.sh build
