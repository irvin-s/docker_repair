FROM debian:stretch-slim

RUN groupadd -r bitcoin && useradd -r -m -g bitcoin bitcoin

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget git make g++ python-leveldb libboost-all-dev libssl-dev libdb++-dev pkg-config libminiupnpc-dev wget xz-utils \
	&& rm -rf /var/lib/apt/lists/*

# install bitcoin binaries
WORKDIR /home/potcoin
RUN mkdir bin src
RUN echo PATH=\"\$HOME/bin:\$PATH\" >> .bash_profile

WORKDIR /home/potcoin/src
RUN git clone https://github.com/potcoin-project/potcoin.git

WORKDIR	/home/potcoin/src/potcoin/src
RUN make -f makefile.unix
RUN strip potcoind
RUN cp -f potcoind /home/potcoin/bin/
RUN make -f makefile.unix clean

WORKDIR	 /home/potcoin
RUN mkdir .potcoin
RUN cp -f src/potcoin/contrib/docker/potcoin.conf .potcoin/

# create data directory
ENV BITCOIN_DATA /data
RUN mkdir "$BITCOIN_DATA" \
	&& chown -R bitcoin:bitcoin "$BITCOIN_DATA" \
	&& ln -sfn "$BITCOIN_DATA" /home/bitcoin/.potcoin \
	&& chown -h bitcoin:bitcoin /home/bitcoin/.potcoin
VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9332 9333 19335 19332 19444 19332
CMD ["potcoind"]
