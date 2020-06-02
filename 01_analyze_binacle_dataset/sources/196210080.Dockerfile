FROM dockercask/base
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN pacman -S --noconfirm npm python2
RUN npm install -g grunt-cli
RUN npm install -g jspm
RUN npm install -g typescript
RUN npm install -g tslint

WORKDIR /mount
