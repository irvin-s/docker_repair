FROM mhart/alpine-node:latest
MAINTAINER Jonas Colmsjö <jonas@gizur.com>

RUN npm install --global yarn

RUN apk --no-cache add tini git openssh-client \
    && apk --no-cache add --virtual devs tar curl

RUN mkdir /app

WORKDIR /app
ADD package.json .
ADD yarn.lock .
ADD index.js .
ADD config.json .
ADD .babelrc .

RUN yarn install

EXPOSE 53/udp 53/tcp

ENTRYPOINT ["/sbin/tini"]

CMD ["yarn", "start"]
