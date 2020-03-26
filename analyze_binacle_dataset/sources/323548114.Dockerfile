FROM golang:1.10-alpine as builder

MAINTAINER Matthew Slipper <kyokan.io>

COPY . /go/src/github.com/kyokan/drawbridge

ENV GODEBUG netdns=cgo

WORKDIR /go/src/github.com/kyokan/drawbridge

RUN apk add --no-cache \
    alpine-sdk \
    nodejs \
    nodejs-npm \
&&  curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh \
&&  npm i -g truffle \
&&  cd solidity \
&&  npm install --ignore-scripts \
&&  cd /go/src/github.com/kyokan/drawbridge \
&&  mv /go/src/github.com/kyokan/drawbridge/docker/drawbridge/abigen /bin/ \
&&  go get -v github.com/ethereum/go-ethereum \
&&  dep ensure -v \
&&  cp -r \
        "/go/src/github.com/ethereum/go-ethereum/crypto/secp256k1/libsecp256k1" \
        "vendor/github.com/ethereum/go-ethereum/crypto/secp256k1/" \
&&  make compile

FROM alpine as final

COPY --from=builder /go/src/github.com/kyokan/drawbridge/build/drawbridge /bin/
COPY start-drawbridge.sh .
RUN chmod +x start-drawbridge.sh