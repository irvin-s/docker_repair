# https://github.com/ches/docker-kafka
FROM java:8-alpine

ARG KAFKA_VERSION
ARG SCALA_VERSION
ARG KAFKA_HOME

ENV KAFKA_VERSION=${KAFKA_VERSION:-0.10.1.0} \
    SCALA_VERSION=${SCALA_VERSION:-2.11.8} \
    KAFKA_HOME=${KAFKA_HOME:-/opt/kafka} \
    JMX_PORT=7203

RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates \
    && apk add --no-cache bash \
    && cd "/tmp" \
    && SCALA_BINARY_VERSION=$(echo "${SCALA_VERSION:-2.11}" | sed 's#\([0-9]*\.[0-9]*\).*#\1#') \
    && wget -O - http://apache.mirror.cdnetworks.com/kafka/$KAFKA_VERSION/kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz | tar xzf - \
    && mkdir -p $KAFKA_HOME \
    && mv "kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION/"* $KAFKA_HOME \
    && apk del build-dependencies \
    && rm -rf "/tmp/"* \
    \
    && echo "Set up a user to run Kafka" \
    && addgroup kafka \
    && adduser -S -H -h $KAFKA_HOME -s /sbin/nologin -D -g kafka kafka \
    && mkdir -p $KAFKA_HOME/data $KAFKA_HOME/logs \
    && chown -R kafka:kafka $KAFKA_HOME $KAFKA_HOME/data $KAFKA_HOME/logs

COPY config $KAFKA_HOME/config
COPY docker-entrypoint.sh entrypoint.sh

USER kafka

WORKDIR $KAFKA_HOME

VOLUME ["$KAFKA_HOME/data", "$KAFKA_HOME/logs"]

EXPOSE 9092 ${JMX_PORT}

ENTRYPOINT ["/entrypoint.sh"]