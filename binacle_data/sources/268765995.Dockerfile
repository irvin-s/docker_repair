FROM alpine:3.5

RUN \
  apk add --update go git make gcc musl-dev ca-certificates && \
  git clone --depth 1 https://github.com/dubaicoin-dbix/go-dubaicoin && \
  (cd go-ethereum && make gdbix) && \
  cp go-ethereum/build/bin/gdbix /gdbix && \
  apk del go git make gcc musl-dev && \
  rm -rf /go-dubaicoin && rm -rf /var/cache/apk/*

EXPOSE 7565
EXPOSE 57955

ENTRYPOINT ["/gdbix"]
