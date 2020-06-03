FROM stratio/cassandra-lucene-index:3.0.10.3

MAINTAINER eduardoalonso <eduardoalonso@stratio.com>

ENV MAVEN_VERSION 3.3.3

RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV CASSANDRA_CONFIG /etc/sds/cassandra

RUN apt-get update && apt-get install -y --no-install-recommends git

VOLUME /var/lib/cassandra/data
# expose ports 9042=CQL Native Transport Port, 7199=JMX

EXPOSE 9042 7199 7077

# SPARK
ENV SPARK_VERSION 2.1.0
ENV HADOOP_VERSION 2.6
ENV SPARK_PACKAGE $SPARK_VERSION-bin-hadoop$HADOOP_VERSION
ENV SPARK_HOME /usr/spark-$SPARK_PACKAGE
ENV PATH $PATH:$SPARK_HOME/bin
RUN curl -sL --retry 3 "http://apache.rediris.es/spark/spark-$SPARK_VERSION/spark-$SPARK_PACKAGE.tgz" | gunzip | tar x -C /usr/ && ln -s $SPARK_HOME /usr/spark

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN mkdir /home/example

COPY cassandra-lucene-index-examples-spark-1.0-SNAPSHOT.jar /home/example/cassandra-lucene-index-plugin-examples-spark.jar
COPY CreateTableAndPopulate.cql /home/example/

ENTRYPOINT ["/docker-entrypoint.sh"]