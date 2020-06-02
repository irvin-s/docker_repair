FROM alpine:3.9.4

RUN apk add --update alpine-sdk && \
  apk add --no-cache git && \
  apk add --update nodejs nodejs-npm && \
  apk add --update ffmpeg python

WORKDIR /usr/src/app
COPY . .
RUN npm install --silent
RUN npm test
CMD [ "npm", "start" ]