FROM debian:stretch-slim

RUN groupadd -r groestlcoin && useradd -r -m -g groestlcoin groestlcoin

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu wget \
	&& rm -rf /var/lib/apt/lists/*

ENV GROESTLCOIN_VERSION 2.16.3
ENV GROESTLCOIN_URL https://github.com/Groestlcoin/groestlcoin/releases/download/v2.16.3/groestlcoin-2.16.3-x86_64-linux-gnu.tar.gz
ENV GROESTLCOIN_SHA256 f15bd5e38b25a103821f1563cd0e1b2cf7146ec9f9835493a30bd57313d3b86f

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
