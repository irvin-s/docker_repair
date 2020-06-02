FROM wouterd/java7

MAINTAINER Wouter Danes <wouter@wouterdanes.net>

ADD http://ftp.nluug.nl/internet/apache/kafka/0.8.1.1/kafka_2.9.2-0.8.1.1.tgz /kafka.tgz

RUN mkdir -p /kafka && \
  cd /kafka && \
  tar xvfz ../kafka.tgz --strip-components=1 && \
  rm /kafka.tgz

ADD start-server.sh /

RUN chmod +x /start-server.sh

ADD server.properties.initial /server.properties

CMD ["/start-server.sh"]

EXPOSE 9092
