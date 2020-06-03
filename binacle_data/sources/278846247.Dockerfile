FROM openjdk:8u102-jre

ENV KAFKA_VERSION=0.10.1.1
ENV SCALA_VERSION=2.11.8
ENV KAFKA_BIN_VERSION=2.11-$KAFKA_VERSION

RUN curl -SLs "http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb" -o scala.deb \
    && dpkg -i scala.deb \
    && rm scala.deb \
    && curl -SLs "http://www.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$KAFKA_BIN_VERSION.tgz" | tar -xzf - -C /opt && \
    apt-get update && \
    apt-get install -y vim


WORKDIR /opt/kafka_$KAFKA_BIN_VERSION
ENTRYPOINT ["bin/kafka-server-start.sh"]

CMD ["/etc/kafka/server.properties"]
