FROM ubuntu:xenial

ENV PATH=/usr/lib/go-1.9/bin:$PATH

RUN \
  apt-get update && apt-get upgrade -q -y && \
  apt-get install -y --no-install-recommends golang-1.9 git make gcc libc-dev ca-certificates && \
  git clone --depth 1 https://github.com/expanse-org/go-expanse && \
  (cd go-expanse && make geth) && \
  cp go-expanse/build/bin/gexo /gexp && \
  apt-get remove -y golang-1.9 git make gcc libc-dev && apt autoremove -y && apt-get clean && \
  rm -rf /go-expanse

EXPOSE 9656
EXPOSE 42786

ENTRYPOINT ["/gexp"]
