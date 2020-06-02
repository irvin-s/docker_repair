FROM elevy/slim_java:8

ENV ZK_VERSION 3.4.10

RUN apk add --no-cache --virtual .build-deps \
      ca-certificates   \
      gnupg             \
      tar               \
      wget &&           \
    #
    # Install dependencies
    apk add --no-cache  \
      bash &&           \
    #
    # Download Zookeeper
    wget -nv -O /tmp/zk.tgz "https://www.apache.org/dyn/closer.cgi?action=download&filename=zookeeper/stable/zookeeper-${ZK_VERSION}.tar.gz" && \
    wget -nv -O /tmp/zk.tgz.asc "https://www.apache.org/dist/zookeeper/zookeeper-${ZK_VERSION}/zookeeper-${ZK_VERSION}.tar.gz.asc" && \
    wget -nv -O /tmp/KEYS https://dist.apache.org/repos/dist/release/zookeeper/KEYS && \
    #
    # Verify the signature
    export GNUPGHOME="$(mktemp -d)" && \
    gpg -q --batch --import /tmp/KEYS && \
    gpg -q --batch --no-auto-key-retrieve --verify /tmp/zk.tgz.asc /tmp/zk.tgz && \
    #
    # Set up directories
    #
    mkdir -p /zookeeper/data /zookeeper/wal /zookeeper/log && \
    #
    # Install
    tar -x -C /zookeeper --strip-components=1 --no-same-owner -f /tmp/zk.tgz && \
    #
    # Slim down
    cd /zookeeper && \
    cp dist-maven/zookeeper-${ZK_VERSION}.jar . && \
    rm -rf \
      *.txt \
      *.xml \
      bin/README.txt \
      bin/*.cmd \
      conf/* \
      contrib \
      dist-maven \
      docs \
      lib/*.txt \
      lib/cobertura \
      lib/jdiff \
      recipes \
      src \
      zookeeper-*.asc \
      zookeeper-*.md5 \
      zookeeper-*.sha1 && \
    #
    # Clean up
    apk del .build-deps && \
    rm -rf /tmp/* "$GNUPGHOME"

COPY conf /zookeeper/conf/
COPY bin/zkReady.sh /zookeeper/bin/
COPY entrypoint.sh /

ENV PATH=/zookeeper/bin:${PATH} \
    ZOO_LOG_DIR=/zookeeper/log \
    ZOO_LOG4J_PROP="INFO, CONSOLE, ROLLINGFILE" \
    JMXPORT=9010

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "zkServer.sh", "start-foreground" ]

EXPOSE 2181 2888 3888 9010
