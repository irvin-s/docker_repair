ARG TENDERMINT_VERSION=latest
FROM XuanMaoSecLab/DolphinChain:${TENDERMINT_VERSION}

COPY tm-signer-harness /usr/bin/tm-signer-harness
