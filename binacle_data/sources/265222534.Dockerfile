FROM ubuntu:xenial

RUN \
  apt-get update && apt-get upgrade -q -y && \
  apt-get install -y --no-install-recommends golang git make gcc libc-dev ca-certificates && \
  git clone --depth 1 https://github.com/nekonium/go-nekonium && \
  (cd go-nekonium && make gnekonium) && \
  cp go-nekonium/build/bin/gnekonium /gnekonium && \
  apt-get remove -y golang git make gcc libc-dev && apt autoremove -y && apt-get clean && \
  rm -rf /go-nekonium

EXPOSE 8293
EXPOSE 28568

ENTRYPOINT ["/gnekonium"]
