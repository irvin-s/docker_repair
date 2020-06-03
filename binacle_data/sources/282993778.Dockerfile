FROM ubuntu:16.10
MAINTAINER pa_ssion
LABEL Description="Gopherz/2 Basic Challenge" VERSION='1.0'

RUN apt update -y && apt install -y curl apt-transport-https wget

RUN wget nodejs.org/dist/v8.6.0/node-v8.6.0-linux-x64.tar.gz
RUN tar -C /usr/local --strip-components 1 -xzf node-v8.6.0-linux-x64.tar.gz

RUN apt update -y

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update -y && apt install -y yarn

COPY cardnames.txt /opt/
COPY app.js /opt/
COPY flag.txt /
COPY nodepherz/ /opt/nodepherz/

RUN cd /opt/nodepherz && yarn install
RUN cd /opt/ && yarn install


CMD cd /opt/ && node /opt/app.js