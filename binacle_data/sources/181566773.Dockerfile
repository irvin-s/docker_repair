FROM golang

MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /code

RUN go get github.com/reactjs/react-tutorial

ADD bin/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 3000

CMD ["go","run","server.go"]
