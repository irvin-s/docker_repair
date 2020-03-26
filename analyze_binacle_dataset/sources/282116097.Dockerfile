FROM golang:1.9-alpine
WORKDIR /go/src/github.com/getline-network/getline/
RUN set -e -x ;\
    apk add --no-cache --virtual .build-deps \
        gcc musl-dev openssl protobuf

COPY vendor vendor
COPY pb pb
COPY metabackend metabackend
RUN go install github.com/getline-network/getline/vendor/github.com/golang/protobuf/protoc-gen-go
RUN go generate github.com/getline-network/getline/pb
RUN go build -o /metabackend github.com/getline-network/getline/metabackend

FROM golang:1.9-alpine
RUN set -e -x ;\
    addgroup -S app ;\
    adduser -S -g app app ;\
    mkdir /app ;\
    chown app:app /app

USER app
WORKDIR /app
COPY dapp/build build
COPY --from=0 /metabackend .
