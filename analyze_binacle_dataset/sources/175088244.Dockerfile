FROM nodesource/trusty:0.10

MAINTAINER David Bruant <bruant.d@gmail.com>

RUN npm install nodemon -g

RUN mkdir /usr/mywi
WORKDIR /usr/mywi 

EXPOSE 3333
