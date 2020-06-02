FROM ubuntu:16.04
MAINTAINER Zhouxu Long

RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y python

RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_7.x
RUN apt-get install -y nodejs

