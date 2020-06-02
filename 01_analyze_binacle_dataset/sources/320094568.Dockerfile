FROM alpine:3.7 as build
RUN apk update && apk add nodejs=8.9.3-r1 && npm install --global yarn@1.6.0
WORKDIR /app
