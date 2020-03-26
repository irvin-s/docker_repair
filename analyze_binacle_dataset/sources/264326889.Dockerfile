FROM alpine
RUN apk update;apk add nodejs nodejs-npm
COPY * /btc/
WORKDIR /btc
CMD npm install;node main.js
