FROM golang:latest

ADD server /usr/bin/

EXPOSE 50051

ENV PORT 50051

ENTRYPOINT /usr/bin/server
