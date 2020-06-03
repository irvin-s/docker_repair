FROM golang:alpine AS builder

RUN mkdir /app
ADD *.go /app/

WORKDIR /app

RUN go build -o jload . 

FROM alpine:latest

WORKDIR /root/
COPY --from=builder /app/jload .
ENTRYPOINT ["/bin/sh", "-c", "exec ./jload $0 $@"]
