ARG GO_VERSION=1.11

FROM golang:${GO_VERSION}-alpine AS builder

RUN mkdir /user && \
    echo 'nobody:x:65534:65534:nobody:/:' > /user/passwd && \
    echo 'nobody:x:65534:' > /user/group

RUN apk add --no-cache git

RUN go get -u github.com/DBHeise/wiki

RUN mkdir /data && chown nobody /data

EXPOSE 8000

USER nobody:nobody

ENTRYPOINT ["/go/bin/wiki", "-b", ":8000", "--brand", "Wiki", "--data", "/data"]