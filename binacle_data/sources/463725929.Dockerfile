FROM node:8.9.1-alpine

RUN apk update && apk add wget ca-certificates && \
  wget -O /usr/bin/dumb-init \
  https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 \
  && chmod +x /usr/bin/dumb-init

FROM node:10-alpine

COPY --from=0 /usr/bin/dumb-init /usr/bin/dumb-init

WORKDIR /code

COPY package.json ./
COPY yarn.lock ./

RUN yarn install --production

COPY app.js ./

EXPOSE 8080

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

USER node:node

CMD ["/usr/local/bin/node", "app.js"]
