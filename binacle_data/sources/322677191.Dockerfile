FROM golang:latest

ADD hello-web /usr/bin/

EXPOSE 12345

ENV PORT 12345

ENTRYPOINT /usr/bin/hello-web

