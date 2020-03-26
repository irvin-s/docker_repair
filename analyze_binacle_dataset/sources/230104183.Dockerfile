FROM ubuntu:14.04

WORKDIR /www/data
COPY ./index.html ./
VOLUME /www/data
