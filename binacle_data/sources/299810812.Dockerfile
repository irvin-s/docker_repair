FROM alpine:3.3

RUN \
  apk add --update go git make gcc musl-dev         && \
  git clone https://github.com/dbix-project/go-dubaicoin && \
  (cd go-dubaicoin && make geth)                     && \
  cp go-dubaicoin/build/bin/gdbix /gdbix               && \
  apk del go git make gcc musl-dev                  && \
  rm -rf /go-dubaicoin && rm -rf /var/cache/apk/*

EXPOSE 7565
EXPOSE 57955

ENTRYPOINT ["/gdbix"]
