FROM golang:alpine

EXPOSE 8000/tcp

ENTRYPOINT ["pastebin"]

RUN \
    apk add --update git && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /go/src/pastebin
WORKDIR /go/src/pastebin

COPY . /go/src/pastebin

RUN go get -v -d
RUN go get github.com/GeertJohan/go.rice/rice
RUN rice embed-go
RUN go install -v
