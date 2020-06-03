FROM golang:1.11 AS builder

RUN mkdir -p /go/src/github.com/marwan-at-work/marwanio/frontend && \
    go get -u github.com/gopherjs/gopherjs && \
    mkdir -p /tmp/cache && \
    apt-get update && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    npm i -g webpack && \
    npm i -g webpack-cli

COPY ./frontend/package.json /tmp/cache
COPY ./frontend/package-lock.json /tmp/cache

RUN cd /tmp/cache && npm i

RUN cp -a /tmp/cache/node_modules /go/src/github.com/marwan-at-work/marwanio/frontend

COPY . /go/src/github.com/marwan-at-work/marwanio

WORKDIR /go/src/github.com/marwan-at-work/marwanio

RUN CGO_ENABLED=0 GO111MODULE=on go build -mod=vendor -a -ldflags '-s' && \
    cd /go/src/github.com/marwan-at-work/marwanio/frontend && \
    webpack && \
    gopherjs build github.com/marwan-at-work/marwanio/frontend -o ../public/frontend.js

FROM busybox

RUN mkdir -p /go/src/github.com/marwan-at-work/marwanio/frontend && \
    mkdir -p /go/src/github.com/marwan-at-work/marwanio/blog/posts && \
    mkdir -p /go/src/github.com/marwan-at-work/marwanio/public

WORKDIR /go/src/github.com/marwan-at-work/marwanio

COPY --from=builder /go/src/github.com/marwan-at-work/marwanio/marwanio /go/src/github.com/marwan-at-work/marwanio

COPY --from=builder /go/src/github.com/marwan-at-work/marwanio/public /go/src/github.com/marwan-at-work/marwanio/public

COPY --from=builder /go/src/github.com/marwan-at-work/marwanio/blog/posts /go/src/github.com/marwan-at-work/marwanio/blog/posts

COPY --from=builder /etc/ssl/certs /etc/ssl/certs

EXPOSE 8080

ENTRYPOINT ["/go/src/github.com/marwan-at-work/marwanio/marwanio"]