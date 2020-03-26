FROM alpine:edge

WORKDIR /app

RUN apk add --no-cache caddy nodejs

ADD . /app

RUN npm install && touch Caddyfile

CMD npm start