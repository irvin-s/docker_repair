FROM java:openjdk-8-jdk

ENV hadoop_ver 2.7.0
ENV spark_ver 2.1.0

RUN mkdir -p /opt && \
    cd /opt && \
    curl http://www.eu.apache.org/dist/hadoop/common/hadoop-${hadoop_ver}/hadoop-${hadoop_ver}.tar.gz | \
        tar -zx hadoop-${hadoop_ver}/lib/native && \
    ln -s hadoop-${hadoop_ver} hadoop && \
    echo Hadoop ${hadoop_ver} native libraries installed in /opt/hadoop/lib/native
RUN ls -R /opt/hadoop/

RUN mkdir -p /opt && \
    cd /opt && \
    curl http://www.eu.apache.org/dist/spark/spark-${spark_ver}/spark-${spark_ver}-bin-hadoop2.7.tgz | \
        tar -zx && \
    ln -s spark-${spark_ver}-bin-hadoop2.7 spark && \
    echo Spark ${spark_ver} installed in /opt

RUN curl http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar -o /opt/spark/jars/aws-java-sdk-1.7.4.jar
RUN curl http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.0/hadoop-aws-2.7.0.jar -o /opt/spark/jars/hadoop-aws-2.7.0.jar

RUN apt-get update && \
    apt-get install -y python-numpy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD log4j.properties /opt/spark/conf/log4j.properties
ADD start-common.sh start-worker start-master /
ADD core-site.xml /opt/spark/conf/core-site.xml
ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf
ENV PATH $PATH:/opt/spark/bin
