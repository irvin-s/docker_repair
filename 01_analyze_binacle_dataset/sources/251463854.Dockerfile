# build
FROM node:6-alpine AS build

WORKDIR /app
COPY . .

ARG CONTROLLER_SERVICE=http://lw-controller:8080
ENV CONTROLLER_SERVICE="${CONTROLLER_SERVICE}"

RUN cd /app \
  && apk add --no-cache --virtual .build-deps alpine-sdk python \
  && npm install \
  && npm run deploy:prod \
  && apk del .build-deps

# run
FROM nginx:stable

COPY --from=build /app/dist/ /var/www/
COPY --from=build /app/dist/docker-nginx.conf /etc/nginx/conf.d/default.conf
