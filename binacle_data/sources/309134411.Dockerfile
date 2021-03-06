FROM node:8-alpine

# version for v3 tag. No healthcheck and version set to v3
# fail startup by default

ARG NODE_ENV=production
ENV NODE_ENV=$NODE_ENV \
    PORT=80 \
    VERSION=v3 \
    FAIL_STARTUP=true \
    DELAY_STARTUP=0 \
    DELAY_HEALTHCHECK=0 \
    HAPPYHEALTHCHECK=true \
    ENABLE_LOGGER=true

RUN apk add --no-cache --virtual curl

WORKDIR /opt

COPY package.json package-lock.json* ./

RUN npm install && npm cache clean --force

ENV PATH /opt/node_modules/.bin:$PATH

WORKDIR /opt/app

COPY . /opt/app

# NO HEALTHCHECK

CMD [ "node", "app.js" ]

# vi:syntax=Dockerfile
