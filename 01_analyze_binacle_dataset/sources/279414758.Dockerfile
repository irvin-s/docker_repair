FROM debian:stretch-slim

RUN groupadd -r bitcoin && useradd -r -m -g bitcoin bitcoin

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/*

ENV FEATHERCOIN_VERSION 0.16.0
ENV FEATHERCOIN_URL https://github.com/FeatherCoin/Feathercoin/releases/download/v0.16.0/feathercoin-0.16.0-linux64.tar.gz
ENV FEATHERCOIN_SHA256 908975659c36f6175933340bab50a677c5be15b0630eb30dde8c89c038f5c7cf
ENV FEATHERCOIN_ASC_URL https://github.com/FeatherCoin/Feathercoin/releases/download/v0.16.0/feathercoin-0.16.0-linux64.tar.gz.asc
ENV FEATHERCOIN_PGP_KEY 0xf4f958124751434e

# install feathercoin binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO feathercoin.tar.gz "$FEATHERCOIN_URL" \
	&& echo "$FEATHERCOIN_SHA256 feathercoin.tar.gz" | sha256sum -c - \
	&& gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$FEATHERCOIN_PGP_KEY" \
	&& wget -qO feathercoin.asc "$FEATHERCOIN_ASC_URL" \
	&& gpg --verify feathercoin.asc \
	&& tar -xzvf feathercoin.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm -rf /tmp/*

# create data directory
ENV BITCOIN_DATA /data
RUN mkdir "$BITCOIN_DATA" \
	&& chown -R bitcoin:bitcoin "$BITCOIN_DATA" \
	&& ln -sfn "$BITCOIN_DATA" /home/bitcoin/.feathercoin \
	&& chown -h bitcoin:bitcoin /home/bitcoin/.feathercoin
VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9336 9337 19336 19337 18446 18447
CMD ["feathercoind"]