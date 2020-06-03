FROM golang:1.8-alpine

ENV ROCKSDB_VERSION=5.0.1

RUN apk --update --no-cache add bash curl jq \
    && apk add --virtual .builddeps build-base perl linux-headers musl-dev bzip2-dev snappy-dev zlib-dev coreutils git docker \
    && cd /tmp \
    && curl --insecure -sL https://github.com/facebook/rocksdb/archive/v$ROCKSDB_VERSION.tar.gz | tar zx \
    && mv rocksdb-$ROCKSDB_VERSION rocksdb \
    && ( cd /tmp/rocksdb ; INSTALL_PATH=/usr make install-shared ) \
    && rm -rf /tmp/rocksdb \
    # build hyperledger fabric peer
    && ( mkdir -p /var/hyperledger ; cd /var/hyperledger ; mkdir db production fabric ) \
    # clone hyperledger code
    && mkdir -p $GOPATH/src/github.com/hyperledger \
    && cd $GOPATH/src/github.com/hyperledger \
    && git clone --single-branch -b master --depth 1 http://gerrit.hyperledger.org/r/fabric \
    # install gotools
    && ( cd $GOPATH/src/github.com/hyperledger/fabric/ ;  make gotools )\
    # build peer
    && cd $GOPATH/src/github.com/hyperledger/fabric/peer \
    && CGO_CFLAGS=" " CGO_LDFLAGS="-lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy" go install \
    && cp core.yaml $GOPATH/bin \
    && go clean \
    # build orderer
    && cd $GOPATH/src/github.com/hyperledger/fabric/orderer \
    && go install \
    && cp orderer.yaml $GOPATH/bin \
    && go clean \
    && ls -al $GOPATH/bin \
    && ( apk del .builddeps ; rm -rf /tmp/* )
# [FAB-1054] Remove rocksdb
WORKDIR $GOPATH/src/github.com/hyperledger/fabric
