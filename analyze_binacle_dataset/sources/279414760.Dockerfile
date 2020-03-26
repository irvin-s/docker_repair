FROM debian:stretch-slim

RUN groupadd -r groestlcoin && useradd -r -m -g groestlcoin groestlcoin

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu wget \
	&& rm -rf /var/lib/apt/lists/*

ENV GROESTLCOIN_VERSION 2.16.0
ENV GROESTLCOIN_URL https://github.com/Groestlcoin/groestlcoin/releases/download/v2.16.0/groestlcoin-2.16.0-x86_64-linux-gnu.tar.gz
ENV GROESTLCOIN_SHA256 4e7683bbc6f3b7899761d1360f52a91f417e2b7e6c56b75b522d95b86ca46628

# install groestlcoin binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO groestlcoin.tar.gz "$GROESTLCOIN_URL" \
	&& echo "$GROESTLCOIN_SHA256 groestlcoin.tar.gz" | sha256sum -c - \
	&& tar -xzvf groestlcoin.tar.gz -C /usr/local/bin --exclude=*-qt \
	&& rm -rf /tmp/*

# create data directory
ENV GROESTLCOIN_DATA /data
RUN mkdir "$GROESTLCOIN_DATA" \
	&& chown -R groestlcoin:groestlcoin "$GROESTLCOIN_DATA" \
	&& ln -sfn "$GROESTLCOIN_DATA" /home/groestlcoin/.groestlcoin \
	&& chown -h groestlcoin:groestlcoin /home/groestlcoin/.groestlcoin
VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 1331 1441 17777 17766 18888 18443
CMD ["groestlcoind"]
