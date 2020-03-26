# TODO: Switch to using builder.
FROM node:6.11.2-alpine

RUN apk add --update git && \
  rm /usr/local/bin/yarn && npm install -g yarn && \
  rm -rf /usr/share/man /tmp/* /var/tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

COPY ./package.json ./yarn.lock /app/
WORKDIR /app/

RUN yarn && \
  rm -rf /usr/share/man /tmp/* /var/tmp/* /var/cache/apk/* /root/.node-gyp

COPY . /app/
RUN yarn build

ENV PORT 3000
EXPOSE 3000

CMD ["node", "./dist/server/index.js"]
