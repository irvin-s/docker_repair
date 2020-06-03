FROM golang:1.8-jessie

ARG CHECKOUT_TARGET=master

# TARGET={bootnode|fullnode|miningnode}
ENV TARGET=fullnode

RUN mkdir -p /opt/go-ethereum

RUN git clone https://github.com/ethereum/go-ethereum.git /opt/go-ethereum

WORKDIR /opt/go-ethereum

RUN git checkout $CHECKOUT_TARGET

RUN make all

RUN mkdir /opt/target

WORKDIR /opt/target

RUN mkdir /opt/shared
VOLUME /opt/shared

RUN mkdir /opt/genesis
VOLUME /opt/genesis

EXPOSE 8545
EXPOSE 8546
EXPOSE 30301
EXPOSE 30303
EXPOSE 30304
EXPOSE 6060

COPY run.sh .

ENV NODE_NAME=""
ENV GENESIS_FILE="genesis.json"
ENV MINERTHREADS=1

ENTRYPOINT ["bash", "run.sh"]
CMD []
