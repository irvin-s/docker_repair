FROM ubuntu:latest

RUN apt-get update &&\
	apt-get upgrade

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y install gnome system-config-kickstart

CMD system-config-kickstart
