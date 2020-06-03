FROM dckreg:5000/openjdk:8-jdk

ENV ZOOKEEPER_VERSION   {{ ZOOKEEPER_VERSION }}
ENV ZOOKEEPER_HOME        /opt/zookeeper
ENV PATH        $PATH:$ZOOKEEPER_HOME/bin

RUN mkdir -p /opt /var/sky/zookeeper/data /var/sky/zookeeper/conf \
    && wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-$ZOOKEEPER_VERSION $ZOOKEEPER_HOME

COPY zoo.cfg $ZOOKEEPER_HOME/conf/zoo.cfg
COPY zkGenConfig.sh $ZOOKEEPER_HOME/bin/zkGenConfig.sh
COPY zkOk.sh $ZOOKEEPER_HOME/bin/zkOk.sh

RUN mkdir -p /var/zookeeper/data
RUN touch /var/zookeeper/data/myid

WORKDIR /opt/zookeeper
