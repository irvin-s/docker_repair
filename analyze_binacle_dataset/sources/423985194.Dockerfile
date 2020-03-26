FROM alpine:latest

WORKDIR /home/app

RUN apk add --no-cache figlet

COPY . .

USER 1000:1000
