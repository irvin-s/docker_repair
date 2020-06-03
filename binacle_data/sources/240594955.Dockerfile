FROM golang:alpine as builder
MAINTAINER Jack Murdock <jack_murdock@comcast.com>

# build the binary
WORKDIR /go/src
COPY src/ /go/src/

RUN go build -o caduceus_linux_amd64 caduceus

EXPOSE 6000 6001 6002
RUN mkdir -p /etc/caduceus
VOLUME /etc/caduceus

# the actual image
FROM alpine:latest
RUN apk --no-cache add ca-certificates
RUN mkdir -p /etc/caduceus
VOLUME /etc/caduceus
WORKDIR /root/
COPY --from=builder /go/src/caduceus_linux_amd64 .
ENTRYPOINT ["./caduceus_linux_amd64"]
