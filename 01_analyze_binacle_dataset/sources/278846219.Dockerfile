FROM anapsix/alpine-java

ARG druid_version=0.9.2

RUN apk add --update coreutils wget curl \
	&& rm -f /var/cache/apk/*

RUN adduser -S -H druid \
	&& mkdir -p /var/lib/druid \
	&& chown druid /var/lib/druid

ENV DRUID_VERSION $druid_version
ENV DRUID_HOME /opt/druid
RUN wget -q -O - http://static.druid.io/artifacts/releases/druid-$DRUID_VERSION-bin.tar.gz | tar -xzf - -C /opt \
	&& ln -s /opt/druid-$DRUID_VERSION $DRUID_HOME
RUN wget -q -O - http://static.druid.io/artifacts/releases/mysql-metadata-storage-$DRUID_VERSION.tar.gz | tar -xzf - -C $DRUID_HOME/extensions
ENV PATH="$DRUID_HOME/bin:${PATH}"

# fix bug in quickstart
RUN sed -E -i "s#quickstart/wikiticker-2015-09-12-sampled.json#$DRUID_HOME/quickstart/wikiticker-2015-09-12-sampled.json.gz#" "$DRUID_HOME/quickstart/wikiticker-index.json"

COPY druid /usr/local/bin/druid
COPY docker-entrypoint.sh /usr/local/bin/

USER druid
WORKDIR /var/lib/druid
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["druid", "--help"]
