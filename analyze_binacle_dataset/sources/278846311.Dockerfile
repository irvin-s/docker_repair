FROM anapsix/alpine-java

ARG tranquility_version=0.8.2
ARG druid_version=0.9.2

RUN apk add --update coreutils wget \
	&& rm -f /var/cache/apk/*

RUN adduser -S -H tranquility \
	&& mkdir -p /var/lib/tranquility \
	&& chown tranquility /var/lib/tranquility

ENV DRUID_VERSION $druid_version
ENV DRUID_HOME /opt/druid
RUN wget -q -O - http://static.druid.io/artifacts/releases/druid-$DRUID_VERSION-bin.tar.gz | tar -xzf - -C /opt \
	&& ln -s /opt/druid-$DRUID_VERSION $DRUID_HOME

ENV TRANQUILITY_VERSION $tranquility_version
ENV TRANQUILITY_HOME /opt/tranquility
RUN wget -q -O - http://static.druid.io/tranquility/releases/tranquility-distribution-$TRANQUILITY_VERSION.tgz | tar -xzf - -C /opt \
	&& ln -s /opt/tranquility-distribution-$TRANQUILITY_VERSION $TRANQUILITY_HOME
ENV PATH="${TRANQUILITY_HOME}/bin:${PATH}"

RUN mv "${TRANQUILITY_HOME}/conf" /etc/tranquility && ln -s /etc/tranquility "${TRANQUILITY_HOME}/conf"

USER tranquility
WORKDIR /var/lib/tranquility
ENTRYPOINT ["tranquility"]
CMD ["server", "-configFile", "/etc/tranquility/server.json"]
