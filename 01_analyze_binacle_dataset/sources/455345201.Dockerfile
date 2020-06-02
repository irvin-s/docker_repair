FROM ubuntu:xenial
MAINTAINER ktruong008@gmail.com

RUN apt-get update
RUN apt-get install curl -y
RUN curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn -y
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install nodejs -y
EXPOSE 3000
