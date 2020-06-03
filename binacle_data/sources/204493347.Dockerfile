FROM golang:alpine

RUN apk add --update \
   git

COPY . /go/src/web-pubsub-example/wsb
WORKDIR /go/src/web-pubsub-example/wsb

RUN go get ./
RUN go build

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.0.0/wait /wait
RUN chmod +x /wait

ENTRYPOINT /wait && /go/bin/wsb

EXPOSE 4000
