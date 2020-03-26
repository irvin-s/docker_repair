FROM ubuntu:xenial

ENV PATH=/usr/lib/go-1.9/bin:$PATH

RUN \
  apt-get update && apt-get upgrade -q -y && \
  apt-get install -y --no-install-recommends golang-1.9 git make gcc libc-dev ca-certificates && \
  git clone --depth 1 --branch release/1.8 https://github.com/timenewbank/go-mit && \
  (cd go-mit && make geth) && \
  cp go-mit/build/bin/mit /mit && \
  apt-get remove -y golang-1.9 git make gcc libc-dev && apt autoremove -y && apt-get clean && \
  rm -rf /go-mit

EXPOSE 8545
EXPOSE 9999

ENTRYPOINT ["/mit"]
