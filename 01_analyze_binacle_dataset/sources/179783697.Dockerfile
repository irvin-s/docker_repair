FROM ubuntu:latest

MAINTAINER Roman Krivetsky <r.krivetsky@gmail.com>

ENV DOCKER true

RUN apt-get update && \
	apt-get --yes upgrade && \
	apt-get --yes install sudo man git xdg-user-dirs

RUN useradd \
	--uid 1000 \
	--user-group \
	--groups sudo,users \
	--create-home \
	--password '$1$oZeWxk4p$yD7kDgmEEChHDRjoCDhuc.' \
	fellah

USER fellah

RUN xdg-user-dirs-update

WORKDIR /home/fellah
