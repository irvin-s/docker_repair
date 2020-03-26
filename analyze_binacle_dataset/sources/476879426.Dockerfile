FROM node:6.2
MAINTAINER "Dominic Scheirlinck <dominic@vendhq.com>"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install

COPY . /usr/src/app

RUN npm run build

ENTRYPOINT [ "./index.js" ]
