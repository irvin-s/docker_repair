FROM phusion/baseimage:0.9.17
MAINTAINER pitrho

ENV DEBIAN_FRONTEND noninteractive

# Install Oracle Java 8
RUN apt-add-repository ppa:webupd8team/java \
  && apt-get update \
  && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections \
  && apt-get install -y oracle-java8-installer dnsutils python python-support libjemalloc1

RUN apt install -y oracle-java8-unlimited-jce-policy 

# Install cassandra
ENV CASSANDRA_VERSION %%CASSANDRA_VERSION%%
RUN curl -L -O http://dl.bintray.com/apache/cassandra/pool/main/c/cassandra/cassandra_%%CASSANDRA_VERSION%%_all.deb \
  && dpkg -i cassandra_%%CASSANDRA_VERSION%%_all.deb \
  && update-rc.d -f cassandra remove \
  && rm cassandra_%%CASSANDRA_VERSION%%_all.deb

RUN curl -L -O http://dl.bintray.com/apache/cassandra/pool/main/c/cassandra/cassandra-tools_%%CASSANDRA_VERSION%%_all.deb \
  && dpkg -i cassandra-tools_%%CASSANDRA_VERSION%%_all.deb \
  && update-rc.d -f cassandra remove \
  && rm cassandra-tools_%%CASSANDRA_VERSION%%_all.deb

ENV CASSANDRA_CONFIG /etc/cassandra

# listen to all rpc
RUN sed -ri ' \
		s/^(rpc_address:).*/\1 0.0.0.0/; \
	' "$CASSANDRA_CONFIG/cassandra.yaml"

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 7199 9042 9160

# Add all services files
RUN mkdir /etc/service/cassandra /config
COPY run.sh /etc/service/cassandra/run

COPY cassandra.yaml /etc/cassandra/cassandra.yaml
COPY secrets/keystore.jks /config/keystore
COPY secrets/truststore.jks /config/truststore

# Remove the CRON service
RUN rm -rf /etc/service/cron

# Add cqlshrc file
RUN mkdir /root/.cassandra
COPY cqlshrc /root/.cassandra/cqlshrc

CMD ["/sbin/my_init"]
