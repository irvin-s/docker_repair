FROM japaric/armv7-unknown-linux-gnueabihf:latest
MAINTAINER Katharina Fey <kookie@spacekookie.de>

RUN apt-get update
RUN apt-get install -y  lib32ncurses5 \
                        lib32ncursesw5 \
                        lib32ncurses5-dev \
                        lib32ncursesw5-dev
