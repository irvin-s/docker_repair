FROM ruby:2.4-stretch

ENV TZ Europe/Berlin
ENV LANG en_US.UTF-8

RUN apt-get update -qq
RUN apt-get dist-upgrade -y

RUN groupadd --gid 1000 web && useradd --create-home --uid 1000 --gid 1000 --shell /bin/bash web

RUN apt-get install -y locales-all build-essential htop vim curl telnet mc bwm-ng net-tools mtr-tiny ssh rsync

WORKDIR /home/web/app

USER web
