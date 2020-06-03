FROM golang:latest

ADD msgserver /usr/bin/

EXPOSE 50002

ENV PORT 50002

ENTRYPOINT /usr/bin/msgserver

