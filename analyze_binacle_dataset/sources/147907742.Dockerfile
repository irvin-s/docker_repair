FROM golang:1.10-stretch as builder
MAINTAINER Matteo Scandolo <teo.punto@gmail.com>

WORKDIR /go
ADD . /go/src/github.com/teone/gc-fake-storage
RUN CGO_ENABLED=0 GOOS=linux go build -o /build/go-fake-storage github.com/teone/gc-fake-storage

FROM alpine:3.5
MAINTAINER Matteo Scandolo <teo.punto@gmail.com>

COPY --from=builder /build/go-fake-storage /service/go-fake-storage

EXPOSE 4443

WORKDIR /service
ENTRYPOINT ["/service/go-fake-storage"]