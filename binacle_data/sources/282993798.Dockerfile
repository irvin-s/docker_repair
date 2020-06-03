FROM ubuntu:16.10

MAINTAINER pa_ssion
LABEL Description="Gopherz/2 Notsobasic Challenge" VERSION='1.0'

RUN apt update -y && apt install -y curl apt-transport-https wget

RUN wget nodejs.org/dist/v8.6.0/node-v8.6.0-linux-x64.tar.gz
RUN tar -C /usr/local --strip-components 1 -xzf node-v8.6.0-linux-x64.tar.gz


RUN apt update -y
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update -y && apt install -y yarn
RUN yarn install

RUN apt update -y && apt install -y python3.6 python3-pip

COPY package.json /opt/
COPY app.js /opt/
COPY yarn.lock /opt/
COPY flag.txt /flag.txt
COPY client.py /opt/

COPY nodepherz/ /opt/nodepherz/
RUN cd /opt/nodepherz && yarn install


RUN cd /opt/ && yarn install

RUN mkdir /opt/sandbox

RUN chmod 555 /opt/
RUN chmod 777 /opt/sandbox

RUN adduser yeet

USER yeet

CMD cd /opt/ && node app.js