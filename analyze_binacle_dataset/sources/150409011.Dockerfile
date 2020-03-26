FROM relateiq/oracle-java7

RUN apt-get update
RUN apt-get install -y git curl build-essential make gcc wget

RUN cd /opt && wget http://apache.mirrors.pair.com/cassandra/1.2.9/apache-cassandra-1.2.9-bin.tar.gz
RUN cd /opt && tar zxf apache-cassandra-*.tar.gz
RUN rm /opt/*.tar.gz
RUN mv /opt/apache-cassandra-* /opt/cassandra

RUN apt-get install -y lsof

ADD cassandra.yaml /opt/cassandra/conf/cassandra.yaml
ADD cassandra-env.sh /opt/cassandra/conf/cassandra-env.sh
ADD log4j-server.properties /opt/cassandra/conf/log4j-server.properties
ADD start.sh /opt/cassandra/bin/start.sh
ADD cassandra-topology.properties /opt/cassandra/conf/cassandra-topology.properties
RUN chmod 755 /opt/cassandra/bin/start.sh
RUN mkdir /data
RUN mkdir /logs
RUN mkdir /init

VOLUME [ "/init" ]
VOLUME [ "/logs" ]
VOLUME [ "/data" ]

EXPOSE 7000
EXPOSE 7001
EXPOSE 7199
EXPOSE 9160
EXPOSE 9042

CMD "/opt/cassandra/bin/start.sh"
