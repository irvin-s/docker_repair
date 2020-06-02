FROM alpine:3.5

ENV VERSION=1.5.6

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && apk --update --no-cache add bash curl jq git nodejs \
    && apk add --virtual .builddeps build-base python go musl-dev \
    && curl --insecure -sL https://github.com/ethereum/go-ethereum/archive/v$VERSION.tar.gz | tar zx \
    && mv go-ethereum-$VERSION go-ethereum \
    && (cd go-ethereum && make geth) \
    && cp go-ethereum/build/bin/geth /geth \
    && rm -rf /go-ethereum && rm -rf /var/cache/apk/* \
    && cd /tmp && npm install keythereum\
    && apk del .builddeps \
    && mkdir -p /opt/app \
    && cp -a /tmp/node_modules /opt/app/ \
    && rm -rf /tmp/*

EXPOSE 8545
EXPOSE 30303

WORKDIR /opt/app
ADD package.json /opt/app/package.json
RUN npm install
ADD start.sh curlrpc.sh genesis.json /
RUN chmod +x /start.sh && chmod +x /curlrpc.sh
ADD index.js keyrecover.js contractutils.js hahacoin.sol /opt/app/
ENTRYPOINT ["/geth"]
