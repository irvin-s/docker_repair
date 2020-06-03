FROM java:9-b147
LABEL maintainer="PubNative Team <team@pubnative.net>"

ARG PRESTO_VERSION="0.217"

RUN apt-get update -y \
 && apt-get install -y python-pip python-dev python3-dev \
 && pip install envtpl

LABEL os="debian"
LABEL app="presto"
LABEL version="$PRESTO_VERSION"

ENV PRESTO_DIR /opt/presto
ENV PRESTO_ETC_DIR /etc/presto
ENV PRESTO_DATA_DIR /data

RUN mkdir -p ${PRESTO_DIR} ${PRESTO_ETC_DIR}/catalog \
 && curl -s http://central.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz \
 | tar --strip 1 -vxzC ${PRESTO_DIR} \
 && curl -s http://central.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar > /usr/local/bin/presto \
 && chmod +x /usr/local/bin/presto

WORKDIR ${PRESTO_DIR}

ENV CONFIG_discovery.uri "http://localhost:8080"
ENV CONFIG_http-server.http.port 8080
ENV CONFIG_discovery-server.enabled false
ENV CONFIG_coordinator false
ENV CONFIG_node-scheduler.include-coordinator false
ENV CONFIG_query.max-memory 5GB
ENV CONFIG_query.max-memory-per-node 1GB
ENV CONFIG_query.min-expire-age 720m

ENV NODE_node.data-dir ${PRESTO_DATA_DIR}
ENV NODE_catalog.config-dir ${PRESTO_ETC_DIR}/catalog
ENV NODE_node.environment production

ENV LOG_com.facebook.presto WARN
ENV LOG_com.amazonaws.latency WARN

ENV JAVA_OPTS "-server -XX:+UseG1GC -Xmx3G -Xms3G"

RUN mkdir ${PRESTO_DIR}/scripts \
 && ln -s ${PRESTO_ETC_DIR} ./etc

ADD ./scripts scripts
ADD ./etc ${PRESTO_ETC_DIR}
ADD docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ./bin/launcher --config=${PRESTO_ETC_DIR}/config.properties --jvm-config=${PRESTO_ETC_DIR}/jvm.config --log-levels-file=${PRESTO_ETC_DIR}/log.properties --node-config=${PRESTO_ETC_DIR}/node.properties run
