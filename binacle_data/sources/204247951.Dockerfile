FROM golang:alpine as builder

RUN apk add --no-cache \
        git \
        make \
        gcc \
        musl-dev

ENV REPOSITORY github.com/kotakanbe/go-cve-dictionary
COPY . $GOPATH/src/$REPOSITORY
RUN cd $GOPATH/src/$REPOSITORY && make install


FROM alpine:3.7

MAINTAINER hikachan sadayuki-matsuno

ENV LOGDIR /var/log/vuls
ENV WORKDIR /vuls

RUN apk add --no-cache ca-certificates \
    && mkdir -p $WORKDIR $LOGDIR

COPY --from=builder /go/bin/go-cve-dictionary /usr/local/bin/

VOLUME ["$WORKDIR", "$LOGDIR"]
WORKDIR $WORKDIR
ENV PWD $WORKDIR

ENTRYPOINT ["go-cve-dictionary"]
CMD ["--help"]
