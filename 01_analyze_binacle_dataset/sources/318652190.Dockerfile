FROM alpine:3.7

RUN \
  apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
  git clone --depth 1 --branch release/1.8 https://github.com/timenewbank/go-mit && \
  (cd go-mit && make geth) && \
  cp go-mit/build/bin/mit /mit && \
  apk del go git make gcc musl-dev linux-headers && \
  rm -rf /go-mit && rm -rf /var/cache/apk/*

EXPOSE 8545
EXPOSE 9999

ENTRYPOINT ["/mit"]
