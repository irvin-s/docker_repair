FROM alpine
RUN apk update;apk add nodejs nodejs-npm
COPY * /delays/
WORKDIR /delays
RUN npm install
CMD sleep 120;node main.js
