FROM node:6-alpine

ADD common /app/common
ADD seed /app/seed
ADD server /app/server

ADD package.json /app/package.json

# add build tools for db2 driver
RUN cd /app \
  && apk add --no-cache --virtual .build-deps alpine-sdk python \
  && npm install \
  && apk del .build-deps

ENV NODE_ENV production
ENV PORT 8080
EXPOSE 8080

WORKDIR "/app"
CMD [ "npm", "start" ]
