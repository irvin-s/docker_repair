FROM alpine:latest

RUN apk update --no-cache --no-progress && \
    apk add go && \
    apk add make && \
    apk add bash && \
    apk add git && \
    apk add gcc && \
    apk add musl-dev && \
    apk add sudo

RUN mkdir -p /go/ && \
    mkdir -p /run/docker/plugins && \
    mkdir -p /usr/share/man/man8

ENV GOPATH=/go

RUN go get -u -d github.com/minio/minfs && \
    cd $GOPATH/src/github.com/minio/minfs && \
    make && \
    make install

RUN rm -rf $GOPATH/src

RUN apk del go && \
    apk del make && \
    apk del bash && \
    apk del git && \
    apk del gcc && \
    apk del musl-dev && \
    apk del sudo

COPY _out/bin/miniovol /usr/bin/miniovol
CMD ["miniovol"]
