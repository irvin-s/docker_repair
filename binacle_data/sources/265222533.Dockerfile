FROM alpine:3.5

RUN \
  apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
  git clone --depth 1 https://github.com/nekonium/go-nekonium && \
  (cd go-ethereum && make gnekonium) && \
  cp go-ethereum/build/bin/gnekonium /gnekonium && \
  apk del go git make gcc musl-dev linux-headers && \
  rm -rf /go-nekonium && rm -rf /var/cache/apk/*

EXPOSE 8293
EXPOSE 28568

ENTRYPOINT ["/gnekonium"]
