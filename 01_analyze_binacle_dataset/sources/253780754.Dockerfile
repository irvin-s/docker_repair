FROM ubuntu:16.04

ENV HOME=/root

ENV PATH=$HOME/.cabal/bin:$HOME/.local/bin:$PATH

COPY stack-setup /stack-setup

COPY .project-copy/ /stack-setup/

RUN apt-get -y update          \
    && apt-get -y install git  \
    && apt-get -y install wget \
    && ( wget -qO- https://get.haskellstack.org/ | sh )            \
    && git clone https://github.com/commercialhaskell/stack /stack \
    && cd /stack     \
    && stack setup   \
    && stack install \
    && cd /          \
    && rm -rf /stack \
    && /bin/bash /stack-setup/setup.sh \
    && cd / \
    && rm -rf /stack-setup

VOLUME /work

WORKDIR /work

ENTRYPOINT /bin/bash
