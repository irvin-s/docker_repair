FROM arm64v8/node:10.13.0-alpine

COPY ./assets/binary/qemu-aarch64-static /usr/bin/qemu-aarch64-static

RUN apk add --no-cache git

RUN npm config set unsafe-perm true

RUN npm install pm2 gulp -g

ADD package-lock.json package.json /tmp/
RUN cd /tmp && npm install
RUN mkdir -p /usr/src/app && cp -a /tmp/node_modules /usr/src/app/

WORKDIR /usr/src/app

COPY . /usr/src/app

RUN npm run prod \
 && npm prune --production

EXPOSE 3001

CMD pm2 start app.json --no-daemon
