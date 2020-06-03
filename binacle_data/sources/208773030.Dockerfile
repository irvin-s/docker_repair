FROM ubuntu:16.04

RUN apt-get update && apt-get -y upgrade && \
    apt-get -y install curl libappindicator1 fuse libgconf-2-4 psmisc

RUN curl -O https://prerelease.keybase.io/keybase_amd64.deb
RUN dpkg -i keybase_amd64.deb
RUN apt-get install -f
RUN useradd -m dev

USER dev

WORKDIR /home/dev