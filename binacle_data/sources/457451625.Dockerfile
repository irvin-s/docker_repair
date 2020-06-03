FROM node:8.9.4-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh openssl

RUN apk add dos2unix --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN npm install nodemon -g

COPY ./package.json /usr/src/app/
RUN npm install

COPY ./ /usr/src/app

RUN dos2unix /usr/src/app/start-dev.sh

EXPOSE 8080

CMD [ "npm", "start" ]
