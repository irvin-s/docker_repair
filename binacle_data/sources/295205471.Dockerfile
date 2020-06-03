FROM golang:1.7.5

MAINTAINER Herman Junge <herman.junge@consensys.net>

################################################################################
#
# Preparation
#
################################################################################

RUN mkdir -p /execs

################################################################################
#
# Geth version v1.5.9 && node
# node (ECDSA pub/priv key)
#
################################################################################

COPY ./01-servers/assets-machine/nodekey.go /go/src/nodekey.go

RUN apt-get update -y \
 && apt-get upgrade -y \
 && apt-get install -y vim-common \
 && mkdir -p /go/src/github.com/ethereum/go-ethereum \
 && git clone --depth 1 -b v1.5.9 https://github.com/ethereum/go-ethereum.git /go/src/github.com/ethereum/go-ethereum \
 && cd /go/src/github.com/ethereum/go-ethereum \
 && make geth \
 && mv /go/src/github.com/ethereum/go-ethereum/build/bin/geth /execs/geth \
 && cd /go/src \
 && go build /go/src/nodekey.go \
 && mv /go/src/nodekey /execs/nodekey \
 && rm -rf /go

################################################################################
#
# Node.js 4.8.0
# Quorum Genesis File Generator Utility (unique commit in repo)
#
################################################################################

ENV NODE_VERSION 4.8.0

RUN set -ex \
 && for key in \
   9554F04D7259F04124DE6B476D5A82AC7E37093B \
   94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
   0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
   FD3A5288F042B6850C66B31F09FE44734EB7990E \
   71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
   DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
   B9AE9905FFD7803F25714661B63B535A4C206CA9 \
   C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
   56730D5401028683275BD23C23EFEFE93C4CFFFE \
 ; do \
   gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
 done \
 && cd /tmp \
 && apt-get install xz-utils \
 && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
 && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
 && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
 && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
 && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
 && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
 && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
 && git clone https://github.com/davebryson/quorum-genesis.git /quorum-genesis \
 && cd /quorum-genesis \
 && npm install

################################################################################
#
# Constellation
# commit c84d0771a6c52c9e3a79d9694db25349b48649ed
# March 27th
#
################################################################################

RUN git clone https://github.com/jpmorganchase/constellation.git /constellation \
 && cd /constellation \
 && git reset c84d0771a6c52c9e3a79d9694db25349b48649ed --hard \
 && apt-get update -y \
 && apt-get upgrade -y \
 && apt-get install -y libdb-dev libsodium-dev zlib1g-dev libtinfo-dev \
 && curl -sSL https://get.haskellstack.org/ | sh \
 && stack setup \
 && stack install \
 && mv /root/.local/bin/constellation-* /execs/. \
 && rm -rf /root/.stack \
 && rm -rf /constellation \
 && rm -rf /var/apt/lib/apt/lists/*

# We are good to go
WORKDIR /execs
