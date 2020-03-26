FROM relateiq/oracle-java7

RUN apt-get update
RUN apt-get install -y git curl build-essential make gcc wget

ENV VERSION 0.7.1
RUN wget http://www.alliedquotes.com/mirrors/apache/incubator/kafka/kafka-$VERSION-incubating/kafka-$VERSION-incubating-src.tgz
RUN tar xzvf kafka-$VERSION-incubating-src.tgz
RUN ln -sfn kafka-$VERSION-incubating kafka
RUN cd kafka && ./sbt update
RUN cd kafka && ./sbt package

RUN mkdir /data && mkdir /logs

ADD server.properties kafka/config/server.properties
ADD kafka-start.sh kafka/kafka-start.sh

ENV JMX_PORT 7203

VOLUME [ "/data" ]
VOLUME [ "/logs" ]

# primary
EXPOSE 9092
# jmx
EXPOSE 7203

CMD ["kafka/kafka-start.sh"]
