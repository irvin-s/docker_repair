# stage 1
FROM golang:1.12.4-alpine3.9 AS build_base

RUN apk add bash ca-certificates git gcc g++ libc-dev

ENV GO111MODULE=on

WORKDIR /src

COPY go.mod .
COPY go.sum .

RUN go mod download


# stage 2
FROM build_base AS builder

ADD . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o jwt_proxy ./cmd


# stage 3
FROM alpine:3.8

RUN apk add ca-certificates

WORKDIR /etc/jwt_proxy

COPY certs /etc/jwt_proxy/certs
COPY www /etc/jwt_proxy/www
COPY config.yml /etc/jwt_proxy/config.yml
COPY --from=builder /src/jwt_proxy .

ENTRYPOINT ["./jwt_proxy"]

EXPOSE 8080