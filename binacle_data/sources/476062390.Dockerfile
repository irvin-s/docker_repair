FROM openjdk:8-jdk-alpine

MAINTAINER Yoan-Alexander Grigorov <joan.grigorov@gmail.com>

ENV MEMORY_LIMIT=512

RUN mkdir /usr/local/src

ADD glagol-server /usr/bin/glagol-server
ADD glagol-dsl.jar /usr/local/src/glagol-dsl-server.jar

RUN chmod +x /usr/bin/glagol-server

ENTRYPOINT ["glagol-server"]
CMD ["daemon"]
