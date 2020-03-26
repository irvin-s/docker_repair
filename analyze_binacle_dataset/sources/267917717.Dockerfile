FROM ubuntu:18.04

WORKDIR /build_docker

COPY docker/daemon/deps.sh /build_docker/docker/daemon/deps.sh
RUN sh docker/daemon/deps.sh

RUN apt-get update && apt-get install -qfy python-pip
COPY docker/daemon/requirements.txt /build_docker/requirements.txt
RUN pip install -r requirements.txt --require-hashes

COPY docker/daemon/build-with-wallet.sh /build_docker/docker/daemon/build-with-wallet.sh

# Install bitcoind from bitcoin/0.17 (v0.17.0rc4)
ARG CORE_DAEMON_NAME
ENV CORE_BRANCH_COMMIT=e1ed37edaedc85b8c3468bd9a726046344036243
ENV CORE_REPO_HOST=https://github.com/bitcoin
ENV CORE_REPO_NAME=bitcoin
RUN sh /build_docker/docker/daemon/build-with-wallet.sh $CORE_BRANCH_COMMIT $CORE_REPO_NAME $CORE_REPO_HOST $CORE_DAEMON_NAME

# Install elementsd
ARG ELEMENTS_DAEMON_NAME
ENV ELEMENTS_BRANCH_COMMIT=4380518d78548415f7165ece5972096b5b4d4ed1
ENV ELEMENTS_REPO_HOST=https://github.com/jtimon
ENV ELEMENTS_REPO_NAME=elements
RUN sh /build_docker/docker/daemon/build-with-wallet.sh $ELEMENTS_BRANCH_COMMIT $ELEMENTS_REPO_NAME $ELEMENTS_REPO_HOST $ELEMENTS_DAEMON_NAME

# Install bitcoind with signet support from jtimon/signet-explorer
# TODO maintain only one branch directly on top of next elements' rebase or bitcoin core's master
ARG SIGNET_DAEMON_NAME
ENV SIGNET_BRANCH_COMMIT=b4c9e7838f16e1947804e6cb12c2282bcb0f9deb
RUN sh /build_docker/docker/daemon/build-with-wallet.sh $SIGNET_BRANCH_COMMIT $ELEMENTS_REPO_NAME $ELEMENTS_REPO_HOST $SIGNET_DAEMON_NAME

ARG ENV_NAME
COPY docker/common /build_docker/common
COPY docker/daemon-conf /build_docker/daemon-conf
COPY docker/$ENV_NAME/conf/torrc /etc/torrc
COPY docker/$ENV_NAME/conf/daemons.proc /build_docker/docker/conf/daemons.proc
CMD honcho start -e common/daemons.env -f docker/conf/daemons.proc
