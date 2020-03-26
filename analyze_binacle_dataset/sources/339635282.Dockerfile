FROM debian:stretch-slim

RUN apt-get update && mkdir -p /usr/share/man/man1 \
    && apt-get install -y --no-install-recommends wget default-jre-headless
RUN wget -O /usr/bin/amm https://github.com/lihaoyi/Ammonite/releases/download/1.1.2/2.12-1.1.2
RUN chmod +x /usr/bin/amm

ADD src/transfer.sc .
RUN amm -c 'import $file.transfer'
RUN ln -s /transfer.sc /usr/bin/transfer
RUN /usr/bin/transfer || true

ADD src/new-wallet.sc .
RUN amm -c 'import $file.`new-wallet`'
RUN ln -s /new-wallet.sc /usr/bin/new-wallet
RUN /usr/bin/new-wallet || true

ADD src/address.sc .
RUN amm -c 'import $file.address'
RUN ln -s /address.sc /usr/bin/address
RUN /usr/bin/address || true

ADD src/balance.sc .
RUN amm -c 'import $file.balance'
RUN ln -s /balance.sc /usr/bin/balance
RUN /usr/bin/balance || true
