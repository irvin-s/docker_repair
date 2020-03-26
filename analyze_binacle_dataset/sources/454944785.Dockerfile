# Copyright 2017 - Dechain User Group

FROM ethereum/client-go:v1.7.2
LABEL name=devchain

ENTRYPOINT /root/run-geth.sh
WORKDIR /root

RUN apk add --update bash vim less
# we expose the RPC and WebSocket port. We don't expose the node port because we don't need to sync with other nodes.
EXPOSE 8545 8546 30303

COPY ./files/* /root/
