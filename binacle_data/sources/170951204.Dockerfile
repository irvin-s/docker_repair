FROM sequenceiq/hadoop-docker:2.5.1
MAINTAINER SequenceIQ

RUN curl -s http://public-repo-1.hortonworks.com/HDP-LABS/Projects/spark/1.1.0/spark-1.1.0.2.1.5.0-702-bin-2.4.0.2.1.5.0-695.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-1.1.0.2.1.5.0-702-bin-2.4.0.2.1.5.0-695 spark
RUN curl -o /usr/local/spark/lib/spark-native-yarn-samples-1.0.jar https://s3-eu-west-1.amazonaws.com/seq-tez/spark-native-yarn-samples-1.0.jar
RUN mkdir /usr/local/spark/sample-data

ENV SPARK_HOME /usr/local/spark
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop/

ADD sample-data /usr/local/spark/sample-data
ADD yarn-remote-client/core-site.xml $SPARK_HOME/external/spark-native-yarn/conf/
ADD yarn-remote-client/yarn-site.xml $SPARK_HOME/external/spark-native-yarn/conf/
ADD yarn-remote-client/tez-site.xml  $YARN_CONF_DIR

RUN $BOOTSTRAP && $HADOOP_PREFIX/bin/hadoop dfsadmin -safemode leave && $HADOOP_PREFIX/bin/hdfs dfs -put /usr/local/spark-1.1.0.2.1.5.0-702-bin-2.4.0.2.1.5.0-695/lib /spark && $HADOOP_PREFIX/bin/hdfs dfs -put /usr/local/spark/sample-data /sample-data

ENV SPARK_JAR hdfs:///spark/spark-assembly-1.1.0.2.1.5.0-702-hadoop2.4.0.2.1.5.0-695.jar
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin

CMD ["/etc/bootstrap.sh", "-d"]
