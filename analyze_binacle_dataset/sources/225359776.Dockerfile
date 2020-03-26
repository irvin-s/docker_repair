FROM centos:latest

MAINTAINER denis@pubnative.net

ENV HADOOP_VERSION 2.7.1
ENV HIVE_VERSION 2.1.1
ENV MYSQL_JDBC=http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.35/mysql-connector-java-5.1.35.jar

RUN yum update -y && \
  yum -y install \
    gettext\
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel \
    wget \
    which

RUN cd /opt && \
  wget http://apache.claz.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
  tar xzf hadoop-$HADOOP_VERSION.tar.gz && \
  mv hadoop-$HADOOP_VERSION hadoop

RUN cd /opt && \
  wget http://artfiles.org/apache.org/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
  tar xzf apache-hive-$HIVE_VERSION-bin.tar.gz && \
  mv apache-hive-$HIVE_VERSION-bin hive

RUN wget $MYSQL_JDBC -P /opt/hive/lib/

COPY conf/mapred-site.xml /opt/hadoop/etc/hadoop/mapred-site.xml
COPY conf/hive-site.xml.tpl /opt/hadoop/etc/hadoop/hive-site.xml.tpl
COPY entrypoint.sh /opt/entrypoint.sh
COPY conf/hive-log4j2.properties /opt/hive/conf/hive-log4j2.properties

ENV HADOOP_USER_CLASSPATH_FIRST true
ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_CLASSPATH $HADOOP_HOME/share/hadoop/tools/lib/*
ENV HADOOP_LIBEXEC_DIR ${HADOOP_HOME}/libexec
ENV PATH=$PATH:/opt/hadoop/bin/:/opt/hive/bin/

RUN rm /opt/hadoop/share/hadoop/common/lib/slf4j-log4j12-*.jar

ENTRYPOINT ["/opt/entrypoint.sh"]
