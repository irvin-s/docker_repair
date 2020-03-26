FROM blairguk/node-sass-alpine:8.9.4
MAINTAINER blair.garrett1@gmail.com
LABEL maintainer="blair.garrett1@gmail.com"

ARG PROD=0
ENV PROD=${PROD}

ARG HOST=0.0.0.0
ENV HOST=${HOST}

ARG SOCKET_URL=wss://localhost:3000
ENV SOCKET_URL=${SOCKET_URL}

ARG BUILD_ENV=build:dev
ENV BUILD_ENV=${BUILD_ENV}

COPY ./src /usr/app/src
COPY webpack.client.config.js webpack.client.prod.config.js webpack.server.config.js webpack.server.prod.config.js package.json package-lock.json /usr/app/

WORKDIR /usr/app

RUN npm i && npm run ${BUILD_ENV}

EXPOSE 3000

CMD [ "npm", "start" ]
