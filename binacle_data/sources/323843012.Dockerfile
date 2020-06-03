FROM ruimarinho/bitcoin-core

COPY bitcoind-regtest.conf /bitcoind-regtest.conf
COPY bitcoind-testnet.conf /bitcoind-testnet.conf
