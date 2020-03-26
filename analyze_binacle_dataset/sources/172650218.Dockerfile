FROM node:argon-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apk update \
    && apk add --update --no-cache ca-certificates ffmpeg \
    && apk del ca-certificates

COPY package.json /usr/src/app/
RUN npm install

COPY . /usr/src/app

EXPOSE 3000
CMD [ "npm", "start" ]