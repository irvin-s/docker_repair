FROM alpine:3.5

ADD . /go-nekonium
RUN \
  apk add --update git go make gcc musl-dev linux-headers && \
  (cd go-nekonium && make gnekonium)                           && \
  cp go-nekonium/build/bin/gnekonium /usr/local/bin/           && \
  apk del git go make gcc musl-dev linux-headers          && \
  rm -rf /go-nekonium && rm -rf /var/cache/apk/*

EXPOSE 8293
EXPOSE 28568
EXPOSE 28568/udp

ENTRYPOINT ["gnekonium"]
