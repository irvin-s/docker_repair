FROM golang:1.10-alpine AS builder

WORKDIR /go/src/github.com/openfaas-incubator/faas-idler

COPY main.go    main.go
COPY vendor     vendor

RUN apk --no-cache add build-base && \
    go build -o /usr/bin/faas-idler .

FROM alpine:3.8

RUN addgroup -S app && adduser -S -g app app
RUN mkdir -p /home/app

WORKDIR /home/app

COPY --from=builder /usr/bin/faas-idler /home/app/

RUN chown -R app /home/app
USER app

EXPOSE 8080
VOLUME /tmp

ENTRYPOINT ["/home/app/faas-idler"]
