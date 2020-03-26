FROM dckreg:5000/java:8

ENV DEBIAN_FRONTEND noninteractive
ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.10.0.1
ENV KAFKA_HOME  /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"
ENV PATH  $PATH:"$KAFKA_HOME"/bin

RUN  wget -q http://apache.mirrors.spacedump.net/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz && \
    tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt && \
    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz


RUN mkdir /etc/jmx_exporter
COPY jmx_exporter.json /etc/jmx_exporter/jmx_exporter.json

RUN useradd -u 9000 -m kafka

COPY kafka-start.sh $KAFKA_HOME/bin/

CMD chmod 755 $KAFKA_HOME/bin/kafka-start.sh

CMD mkdir /etc/kafka

COPY server.properties.template /etc/kafka/

