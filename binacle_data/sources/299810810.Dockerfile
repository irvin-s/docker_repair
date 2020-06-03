FROM alpine:3.3

RUN \
  apk add --update go git make gcc musl-dev         && \
  git clone https://github.com/dbix-project/go-dubaicoin && \
  (cd go-dubaicoin && git checkout develop)          && \
  (cd go-dubaicoin && make gdbix)                     && \
  cp go-dubaicoin/build/bin/gdbix /gdbix               && \
  apk del go git make gcc musl-dev                  && \
  rm -rf /go-dubaicoin && rm -rf /var/cache/apk/*

EXPOSE 9656
EXPOSE 57955

ENTRYPOINT ["/gdbix"]
