FROM ubuntu:trusty
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get -yq update && apt-get -yq upgrade
RUN apt-get -yq install gnupg
RUN apt-get -yq install nodejs-legacy npm
RUN npm install -g keybase-installer
RUN keybase-installer
RUN bash
