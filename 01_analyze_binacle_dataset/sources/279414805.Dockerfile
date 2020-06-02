FROM debian:stretch-slim

RUN groupadd -r viacoin && useradd -r -m -g viacoin viacoin

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/*

ENV VIACOIN_VERSION 0.15.1
ENV VIACOIN_URL https://github.com/viacoin/viacoin/releases/download/v0.15.1/viacoin-0.15.1-x86_64-linux-gnu.tar.gz
ENV VIACOIN_SHA256 673bfd17194ca4fe8408450e1871447d461ce26925e71ea55eebd89c379f5775

# install Viacoin binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO viacoin.tar.gz "$VIACOIN_URL" \
	&& echo "$VIACOIN_SHA256 viacoin.tar.gz" | sha256sum -c - \
	&& tar -xzvf viacoin.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm -rf /tmp/*

# create data directory
# To speed up sync process: https://bootstrap.viacoin.org/
ENV VIACOIN_DATA /data
RUN mkdir "$VIACOIN_DATA" \
	&& chown -R viacoin:viacoin "$VIACOIN_DATA" \
	&& ln -sfn "$VIACOIN_DATA" /home/viacoin/.viacoin \
	&& chown -h viacoin:viacoin /home/viacoin/.viacoin
VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 5222 5223 25222 25223 25222 25223
CMD ["viacoind"]
