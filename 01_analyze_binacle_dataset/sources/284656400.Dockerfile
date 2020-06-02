FROM golang as builder

RUN mkdir -p /go/src/github.com/nirnanaaa
COPY . /go/src/github.com/nirnanaaa/asparagus
WORKDIR /go/src/github.com/nirnanaaa/asparagus
RUN go get github.com/tools/godep && godep restore && ./build.py

FROM busybox:ubuntu-14.04

MAINTAINER "Florian Kasper <florian@xpandmmi.com>"

EXPOSE 9092
WORKDIR /app
ENV PATH=/app:$PATH
COPY --from=builder /etc/ssl /etc/ssl
COPY --from=builder /go/src/github.com/nirnanaaa/asparagus/build/asparagus /app

VOLUME /etc/asparagus

ENTRYPOINT ["asparagus"]
