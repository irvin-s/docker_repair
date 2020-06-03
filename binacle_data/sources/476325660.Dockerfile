FROM wouterd/java7

MAINTAINER Wouter Danes <wouter@wouterdanes.net>

ADD http://ftp.nluug.nl/internet/apache/zookeeper/stable/zookeeper-3.4.6.tar.gz /zookeeper.tar.gz

RUN mkdir -p zoo && \
  cd zoo && \
  tar xvfz ../zookeeper.tar.gz --strip-components=1 && \
  rm /zookeeper.tar.gz

ADD start-server.sh /

RUN chmod +x /start-server.sh

CMD ["/start-server.sh"]

EXPOSE 2888 3888 2181
