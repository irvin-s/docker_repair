FROM java:openjdk-8-jdk

ENV DEBIAN_FRONTEND noninteractive
ENV hadoop_ver 2.7.3
ENV spark_ver 2.2.0
ENV spark_hadoop_ver 2.7

RUN ln -sf /bin/bash /bin/sh

RUN cd /tmp && \
    curl -O http://www.us.apache.org/dist/hadoop/common/hadoop-${hadoop_ver}/hadoop-${hadoop_ver}.tar.gz && \
    curl -O https://archive.apache.org/dist/spark/spark-${spark_ver}/spark-${spark_ver}-bin-hadoop${spark_hadoop_ver}.tgz 

RUN mkdir -p /opt && \
    cd /opt && \
    tar -zxf /tmp/hadoop-${hadoop_ver}.tar.gz hadoop-${hadoop_ver}/lib/native && \
    ln -s hadoop-${hadoop_ver} hadoop && \
    echo Hadoop ${hadoop_ver} native libraries installed in /opt/hadoop/lib/native

# Get Spark from US Apache mirror.
RUN mkdir -p /opt && \
    cd /opt && \
    tar -zxf /tmp/hadoop-${hadoop_ver}.tar.gz hadoop-${hadoop_ver}/lib/native && \
    ln -s hadoop-${hadoop_ver} hadoop && \
    echo Hadoop ${hadoop_ver} native libraries installed in /opt/hadoop/lib/native

# Get Spark from US Apache mirror.
RUN mkdir -p /opt && \
    cd /opt && \
    tar -zxf /tmp/spark-${spark_ver}-bin-hadoop${spark_hadoop_ver}.tgz && \
    ln -s spark-${spark_ver}-bin-hadoop${spark_hadoop_ver} spark && \
    echo Spark ${spark_ver} installed in /opt

RUN apt-get update && apt-get install -y apt-utils apt-transport-https ca-certificates
RUN rm -rf /tmp/* && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y python-numpy python-pip maven && \
    curl -sL https://deb.nodesource.com/setup_7.x | bash && \
    apt-get install -y nodejs build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install boto && \
    update-java-alternatives -s java-1.8.0-openjdk-amd64

ADD log4j.properties /opt/spark/conf/log4j.properties
ADD core-site.xml /opt/spark/conf/core-site.xml
ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf
ADD start-common.sh start-worker start-master /
ENV PATH $PATH:/opt/spark/bin
ENV DEBIAN_FRONTEND teletype
ENV SPARK_HOME /opt/spark
ENV TERM xterm
