FROM golang:1.11.2-alpine3.8

ENV INIT true
ENTRYPOINT ["/main.sh"]

RUN apk add --update bash git
COPY main.sh /
