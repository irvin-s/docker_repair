FROM debian:stretch-slim

RUN groupadd -r groestlcoin && useradd -r -m -g groestlcoin groestlcoin

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu pgp wget \
	&& rm -rf /var/lib/apt/lists/*

ENV GROESTLCOIN_VERSION 2.17.2
ENV GROESTLCOIN_TARBALL groestlcoin-${GROESTLCOIN_VERSION}-x86_64-linux-gnu.tar.gz
ENV GROESTLCOIN_URL https://github.com/Groestlcoin/groestlcoin/releases/download/v$GROESTLCOIN_VERSION/$GROESTLCOIN_TARBALL
ENV GROESTLCOIN_ASC_URL https://github.com/Groestlcoin/groestlcoin/releases/download/v$GROESTLCOIN_VERSION/SHA256SUMS.asc
ENV GROESTLCOIN_PGP_KEY 287AE4CA1187C68C08B49CB2D11BD4F33F1DB499

# install groestlcoin binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO $GROESTLCOIN_TARBALL "$GROESTLCOIN_URL" \
	&& for server in $(shuf -e ha.pool.sks-keyservers.net \
                             hkp://p80.pool.sks-keyservers.net:80 \
                             keyserver.ubuntu.com \
                             hkp://keyserver.ubuntu.com:80 \
                             pgp.mit.edu) ; do \
         gpg --batch --keyserver "$server" --recv-keys "$GROESTLCOIN_PGP_KEY" && break || : ; \
     done \
	&& wget -qO groestlcoin.asc "$GROESTLCOIN_ASC_URL" \
	&& gpg --verify groestlcoin.asc \
	&& grep $GROESTLCOIN_TARBALL groestlcoin.asc | tee SHA256SUMS.asc \
	&& sha256sum -c SHA256SUMS.asc \
	&& tar -xzvf $GROESTLCOIN_TARBALL -C /usr/local/ --strip-components=1 --exclude=*-qt \
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
