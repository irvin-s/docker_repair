FROM mhart/alpine-node:10.12.0

RUN apk add --no-cache git

RUN npm install pm2 gulp -g

ADD package-lock.json package.json /tmp/
RUN cd /tmp && npm install
RUN mkdir -p /usr/src/app && cp -a /tmp/node_modules /usr/src/app/

WORKDIR /usr/src/app

COPY . /usr/src/app

RUN npm run debug \
 && npm prune --production

EXPOSE 3001

CMD pm2 start app.json --no-daemon
