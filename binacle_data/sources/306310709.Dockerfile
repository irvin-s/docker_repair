FROM node:8.12-alpine

RUN apk update && apk add --no-cache git

RUN npm install -g pm2

WORKDIR /srv/coopcycle

COPY package.json /srv/coopcycle
COPY package-lock.json /srv/coopcycle
RUN npm install

COPY docker/nodejs/start.sh /
COPY docker/nodejs/run-tests.sh /

RUN chmod +x /start.sh
RUN chmod +x /run-tests.sh

ENTRYPOINT ["/start.sh"]
