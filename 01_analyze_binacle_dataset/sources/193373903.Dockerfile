FROM node:9.4-alpine

MAINTAINER Ryosuke SATO <rskjtwp@gmail.com>

RUN apk add --no-cache build-base g++ cairo-dev jpeg-dev pango-dev giflib-dev

# https://devcenter.heroku.com/articles/container-registry-and-runtime#run-the-image-as-a-non-root-user
RUN adduser -D chino
USER chino

COPY --chown=chino:root ./ /app
WORKDIR /app
RUN npm install

CMD /app/bin/hubot --adapter slack
