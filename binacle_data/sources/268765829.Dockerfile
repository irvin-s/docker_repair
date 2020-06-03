FROM alpine:3.3

ADD . /go-dubaicoin
RUN \
  apk add --update git go make gcc musl-dev         && \
  (cd go-ethereum && make gdbix)                     && \
  cp go-ethereum/build/bin/gdbix /gdbix               && \
  apk del git go make gcc musl-dev                  && \
  rm -rf /go-dubaiocin && rm -rf /var/cache/apk/*

EXPOSE 7565
EXPOSE 57955

ENTRYPOINT ["/gdbix"]
