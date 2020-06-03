#FROM dockerfile/nodejs:latest
FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y curl wget nodejs

ADD ./demo /demo

RUN ln -s /usr/bin/nodejs /usr/bin/node

VOLUME /demo

EXPOSE 3000
CMD    ["/demo/bin/www"]