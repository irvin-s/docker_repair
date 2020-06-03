FROM openjdk:8-alpine

ARG ZK_VERSION
ARG ZK_HOME

ENV ZK_VERSION=${ZK_VERSION:-3.5.2-alpha}
ENV ZK_HOME=${ZK_HOME:-/opt/zookeeper}

RUN apk add --no-cache --virtual=build-dependencies wget \
    && apk add --no-cache bash \
    && cd /tmp \
    && wget -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz | tar -xzf - \
    \
    && mkdir -p "$ZK_HOME" \
    && cp /tmp/zookeeper*/*.jar $ZK_HOME/ \
    && cp -r /tmp/zookeeper*/lib/ $ZK_HOME/lib/ \
    && cp -r /tmp/zookeeper*/conf/ $ZK_HOME/conf/ \
    && mkdir -p $ZK_HOME/bin \
    && cp /tmp/zookeeper*/bin/*.sh $ZK_HOME/bin/ \
    \
    && sed "s#/tmp/zookeeper#$ZK_HOME/data#g" $ZK_HOME/conf/zoo_sample.cfg > $ZK_HOME/conf/zoo.cfg \
    && apk del build-dependencies \
    \
    && rm -rf /tmp/*

VOLUME ["$ZK_HOME/conf", "${ZK_HOME}/data"]

EXPOSE 2181 2888 3888

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]