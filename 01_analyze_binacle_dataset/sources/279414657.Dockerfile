FROM debian:stretch-slim

RUN groupadd -r bitcoin && useradd -r -m -g bitcoin bitcoin

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/*

ENV BITCOINGOLD_VERSION 0.15.0.2
ENV BITCOINGOLD_URL https://github.com/BTCGPU/BTCGPU/releases/download/v0.15.0.2/bitcoin-gold-0.15.0-x86_64-linux-gnu.tar.gz
ENV BITCOINGOLD_SHA256 c49fa0874333837526cf1b4fce5b58abe6437b48e64dcf095654e6317e1f66a3
ENV BITCOINGOLD_ASC_URL https://github.com/BTCGPU/BTCGPU/releases/download/v0.15.0.2/SHA256SUMS.asc
ENV BITCOINGOLD_PGP_KEY 0x38EE12EB597B4FC0

# install bitcoingold binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO bitcoingold.tar.gz "$BITCOINGOLD_URL" \
	&& echo "$BITCOINGOLD_SHA256 bitcoingold.tar.gz" | sha256sum -c - \
	&& gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$BITCOINGOLD_PGP_KEY" \
	&& wget -qO bitcoingold.asc "$BITCOINGOLD_ASC_URL" \
	&& gpg --verify bitcoingold.asc \
	&& tar -xzvf bitcoingold.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm -rf /tmp/*

# create data directory
ENV BITCOIN_DATA /data
RUN mkdir "$BITCOIN_DATA" \
	&& chown -R bitcoin:bitcoin "$BITCOIN_DATA" \
	&& ln -sfn "$BITCOIN_DATA" /home/bitcoin/.bitcoingold \
	&& chown -h bitcoin:bitcoin /home/bitcoin/.bitcoingold
VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8337 8338 18337 18338 18443 18444
CMD ["bgoldd"]