FROM node:slim

MAINTAINER alaxallves@gmail.com

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && apt-get install -y tree libfontconfig bzip2 xvfb libgtk2.0-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 && npm install --quiet --global vue-cli

WORKDIR /Falko-2017.2-FrontEnd

COPY . /Falko-2017.2-FrontEnd

ADD package.json /Falko-2017.2-FrontEnd/package.json

RUN npm install
