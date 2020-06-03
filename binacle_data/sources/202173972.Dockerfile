
FROM mhart/alpine-node:8

RUN apk add --no-cache make gcc g++ python git iputils drill net-tools

ADD app/package.json /app/
ADD app/wo.js /app/

RUN cd app; npm install
