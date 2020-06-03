FROM ubuntu:xenial

RUN \
  apt-get update && apt-get upgrade -q -y && \
  apt-get install -y --no-install-recommends golang git make gcc libc-dev ca-certificates && \
  git clone --depth 1 https://github.com/dubaicoin-dbix/go-dubaicoin && \
  (cd go-ethereum && make gdbix) && \
  cp go-ethereum/build/bin/gdbix /gdbix && \
  apt-get remove -y golang git make gcc libc-dev && apt autoremove -y && apt-get clean && \
  rm -rf /go-dubaicoin

EXPOSE 7565
EXPOSE 57955

ENTRYPOINT ["/gdbix"]
