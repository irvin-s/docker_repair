FROM golang:latest

ADD wudebao-web /usr/bin/

EXPOSE 54321

ENV PORT 54321

ENTRYPOINT /usr/bin/wudebao-web

