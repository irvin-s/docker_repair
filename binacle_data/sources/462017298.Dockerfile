FROM ubuntu:17.04
MAINTAINER Xiaoquan Kong "u1mail2me@gmail.com"

RUN apt-get update
RUN apt-get install -y build-essential

RUN apt-get install -y vim
RUN apt-get install -y python3-pip