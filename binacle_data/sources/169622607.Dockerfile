FROM dockerfile/java:oracle-java7
MAINTAINER hubt

WORKDIR /usr/local
RUN echo "deb http://debian.datastax.com/community stable main"  >> /etc/apt/sources.list.d/cassandra.sources.list
RUN curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
# add python default scala is too old: 2.9 but we need 2.10
RUN sudo apt-add-repository -y ppa:fkrull/deadsnakes
RUN apt-get update
RUN apt-get -y install python2.7 python-support libjna-java

#add scala
RUN curl -L http://www.scala-lang.org/files/archive/scala-2.10.4.tgz | tar -zx ; ln -s scala-2.10.4 scala
RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.1.0.tgz| tar -xz ; ln -s spark-1.1.0 spark 
RUN cd spark ; sbt/sbt assembly

# use cassandra 2.0.10, because spark doesn't support cassandra 2.1 yet
RUN wget http://debian.datastax.com/community/pool/cassandra_2.0.10_all.deb ; dpkg -i cassandra_2.0.10_all.deb

# install ez_setup and pycass for future python support
#RUN curl -s https://bootstrap.pypa.io/ez_setup.py | python
#RUN easy_install cassandra-driver


# install and build spark-cassandra connector
RUN curl -L -s https://github.com/datastax/spark-cassandra-connector/archive/v1.1.0-alpha2.tar.gz | tar -zx ; ln -s spark-cassandra-connector-1.1.0-alpha2/ spark-cassandra-connector
RUN cd spark-cassandra-connector ; sbt/sbt assembly || true

# java-driver-2.1.1 didn't work, so I use 2.1.0
RUN curl -L http://downloads.datastax.com/java-driver/cassandra-java-driver-2.1.0.tar.gz | tar -zx ; ln -s cassandra-java-driver-2.1.0 cassandra-java-driver

# install sbt
RUN curl -L -s https://dl.bintray.com/sbt/native-packages/sbt/0.13.6/sbt-0.13.6.tgz | tar -zx 

# cassandra host defaults to the real ip so we change it to localhost 
RUN echo spark.cassandra.connection.host 127.0.0.1 >> /usr/local/spark/conf/spark-defaults.conf
RUN echo spark.executor.extraClassPath /usr/local/spark-cassandra-connector-1.1.0-alpha2/spark-cassandra-connector-java/target/scala-2.10/spark-cassandra-connector-java-assembly-1.1.0-alpha2.jar >> /usr/local/spark/conf/spark-defaults.conf
RUN echo spark.driver.extraClassPath /usr/local/spark-cassandra-connector-1.1.0-alpha2/spark-cassandra-connector-java/target/scala-2.10/spark-cassandra-connector-java-assembly-1.1.0-alpha2.jar >> /usr/local/spark/conf/spark-defaults.conf

# cassandra service warns trying to set ulimits in a container, so disable ulimit commands
RUN perl -pi.bak -e 's/ulimit/#ulimit/g' /etc/init.d/cassandra 

# install test data
WORKDIR /root
COPY trigrams /root/trigrams
COPY setup.sql /root/setup.sql
COPY trigram /root/trigram

# start cassandra and load test db
RUN service cassandra start; sleep 15; cqlsh < setup.sql 

# build a nice simple script to run spark-cassandra
RUN echo '#!/bin/bash' > spark-cass ; echo 'spark-shell --jars $(echo /usr/local/cassandra-java-driver/*.jar /usr/local/spark-cassandra-connector/spark-cassandra-connector/target/scala-2.10/*.jar /usr/local/spark-cassandra-connector/spark-cassandra-connector-java/target/scala-2.10/*.jar /usr/share/cassandra/apache-cassandra-thrift-*.jar /usr/share/cassandra/lib/libthrift-*.jar /usr/local/cassandra-java-driver/lib/*.jar | sed -e "s/ /,/g")' >> spark-cass ; chmod 755 spark-cass
RUN echo 'SPARKPATH=$(echo /usr/local/cassandra-java-driver/*.jar /usr/local/spark-cassandra-connector/spark-cassandra-connector/target/scala-2.10/*.jar /usr/local/spark-cassandra-connector/spark-cassandra-connector-java/target/scala-2.10/*.jar /usr/share/cassandra/apache-cassandra-thrift-*.jar /usr/share/cassandra/lib/libthrift-*.jar /usr/local/cassandra-java-driver/lib/*.jar | sed -e "s/ /:/g")' >> spark-cass-env.sh 

ENV PATH /usr/local/spark/bin:/usr/local/cassandra/bin:/usr/local/sbt/bin:/usr/local/scala/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD service cassandra start && /bin/bash
