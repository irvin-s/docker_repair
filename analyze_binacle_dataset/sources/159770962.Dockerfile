FROM ubuntu:12.04
MAINTAINER info@yuki-matsumoto.com

ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update && apt-get -y upgrade
