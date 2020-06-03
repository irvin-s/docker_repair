FROM okchain/testnet-src:_TAG_
RUN mkdir -p /var/okchain/db
COPY bin/* $GOPATH/bin/
WORKDIR $GOPATH/src/github.com/ok-chain/okchain
