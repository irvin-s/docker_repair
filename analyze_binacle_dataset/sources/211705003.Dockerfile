# https://github.com/sheepkiller/kafka-manager-docker
FROM sneck/sbt:0.13.9

ARG KAFKA_MANAGER_VERSION
ARG KAFKA_MANAGER_HOME

ENV KAFKA_MANAGER_VERSION=${KAFKA_MANAGER_VERSION:-1.3.1.6} \
    KAFKA_MANAGER_HOME=${KAFKA_MANAGER_HOME:-/opt/kafka-manager}

RUN apk add --no-cache --virtual=build-dependencies git \
    && apk add --no-cache bash \
    && cd /tmp \
    \
    && mkdir -p ${KAFKA_MANAGER_HOME} \
    \
    && git clone https://github.com/yahoo/kafka-manager.git \
    && cd kafka-manager \
    && git checkout ${KAFKA_MANAGER_VERSION} \
    && sbt clean stage \
    && cp -a /tmp/kafka-manager/target/universal/stage/* $KAFKA_MANAGER_HOME \
    \
    && apk del build-dependencies \
    && rm -rf "/tmp/"* /root/.sbt /root/.ivy2

WORKDIR $KAFKA_MANAGER_HOME

ENTRYPOINT ["./bin/kafka-manager"]