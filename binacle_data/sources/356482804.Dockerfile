FROM golang:1.4.0

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN go get github.com/tools/godep github.com/codegangsta/gin 

RUN mkdir -p /etc/service/doorbot && mkdir -p /go/src/github.com/masom/doorbot

WORKDIR /go/src/github.com/masom/doorbot

COPY ./Godeps /go/src/github.com/masom/doorbot/Godeps
RUN godep restore

COPY . /go/src/github.com/masom/doorbot

RUN go-wrapper download && \
    go-wrapper install


ENTRYPOINT [ "gin" ]
EXPOSE 3000
