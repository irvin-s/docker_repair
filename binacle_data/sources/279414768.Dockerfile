FROM debian:stretch-slim

RUN groupadd -r bitcoin && useradd -r -m -g bitcoin bitcoin

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/*

ENV LITECOIN_VERSION 0.15.1
ENV LITECOIN_URL https://download.litecoin.org/litecoin-0.15.1/linux/litecoin-0.15.1-x86_64-linux-gnu.tar.gz
ENV LITECOIN_SHA256 77062f7bad781dd6667854b3c094dbf51094b33405c6cd25c36d07e0dd5e92e5
ENV LITECOIN_ASC_URL https://download.litecoin.org/litecoin-0.15.1/linux/litecoin-0.15.1-linux-signatures.asc
ENV LITECOIN_PGP_KEY FE3348877809386C

# install litecoin binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO litecoin.tar.gz "$LITECOIN_URL" \
	&& echo "$LITECOIN_SHA256 litecoin.tar.gz" | sha256sum -c - \
	&& gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$LITECOIN_PGP_KEY" \
	&& wget -qO litecoin.asc "$LITECOIN_ASC_URL" \
	&& gpg --verify litecoin.asc \
	&& tar -xzvf litecoin.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm -rf /tmp/*

# create data directory
ENV BITCOIN_DATA /data
RUN mkdir "$BITCOIN_DATA" \
	&& chown -R bitcoin:bitcoin "$BITCOIN_DATA" \
	&& ln -sfn "$BITCOIN_DATA" /home/bitcoin/.litecoin \
	&& chown -h bitcoin:bitcoin /home/bitcoin/.litecoin
VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9332 9333 19335 19332 19444 19332
CMD ["litecoind"]
