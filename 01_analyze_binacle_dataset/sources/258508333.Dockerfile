FROM openjdk:8-jre

ENV ZOOKEEPER_VERSION   3.4.8 
ENV ZOOKEEPER_HOME        /opt/zookeeper
ENV PATH        $PATH:$ZOOKEEPER_HOME/bin

RUN mkdir -p /opt /var/sky/zookeeper/data /var/sky/zookeeper/conf \
    && wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-$ZOOKEEPER_VERSION $ZOOKEEPER_HOME

COPY zoo.cfg $ZOOKEEPER_VERSION/conf/zoo.cfg

WORKDIR /opt/zookeeper


