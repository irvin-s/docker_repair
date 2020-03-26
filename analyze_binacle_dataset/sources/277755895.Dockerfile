FROM mhart/alpine-node:8.9.1

RUN apk update && apk add bash && rm -rf /var/cache/apk/*

RUN mkdir -p /usr/src/app
ADD . /usr/src/app

WORKDIR /usr/src/app

RUN yarn
RUN mkdir ./dist
RUN npm run build

CMD npm run serve
