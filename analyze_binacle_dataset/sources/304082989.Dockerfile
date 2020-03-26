# Build Used in a stock Go builder container
FROM golang:1.12-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git

ADD . /go-usechain
RUN cd /go-usechain && make used
RUN strip /go-usechain/build/bin/used

# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /go-usechain/build/bin/used /usr/local/bin/
RUN mkdir -p /root/.usechain
COPY --from=builder /go-usechain/build/config/profile/mainnetCA.pem /root/.usechain
COPY --from=builder /go-usechain/build/config/profile/moonetCA.pem /root/.usechain

EXPOSE 8848 8849 40404 40404/udp 40405/udp
ENTRYPOINT ["used"]
