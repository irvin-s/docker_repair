# Daniel Malczyk
# ThinkBig Analytics, a Teradata Company

#basic image with CentOS and latest JDK
FROM airhacks/java

MAINTAINER Daniel Malczyk <dmalczyk@gmail.com>

#install hadoop, spark and Hive clients
#------------
#Hadoop client config
RUN curl -s http://www.eu.apache.org/dist/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz | tar -xz -C /usr/local/

#alternative to the command above
#COPY hadoopclient/hadoop-2.7.1.tar.gz .
#RUN tar -xz -C /usr/local/ -f ./hadoop-2.7.1.tar.gz

RUN cd /usr/local && ln -s ./hadoop-2.7.1 hadoop

ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_INSTALL $HADOOP_HOME
ENV HADOOP_PREFIX $HADOOP_HOME
ENV PATH $PATH:$HADOOP_INSTALL/sbin
ENV HADOOP_MAPRED_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_HOME $HADOOP_INSTALL
ENV HADOOP_HDFS_HOME $HADOOP_INSTALL
ENV YARN_HOME $HADOOP_INSTALL
ENV PATH $HADOOP_HOME/bin:$PATH

RUN mkdir -p $HADOOP_PREFIX/etc/hadoop
COPY conf/core-site.xml $HADOOP_PREFIX/etc/hadoop/core-site.xml
COPY conf/hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml

#Install spark to /usr/local/spark
#support for Hadoop 2.6.0
RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz | tar -xz -C /usr/local/

#alternative to the command above
#COPY hadoopclient/spark-1.6.1-bin-hadoop2.6.tgz . 
#RUN tar -xz -C /usr/local/ -f ./spark-1.6.1-bin-hadoop2.6.tgz

RUN cd /usr/local && ln -s spark-1.6.1-bin-hadoop2.6 spark
ENV SPARK_HOME /usr/local/spark

ENV PATH $SPARK_HOME/bin:$PATH

# Install hive
RUN curl -s http://apache.mirrors.spacedump.net/hive/hive-2.1.1/apache-hive-2.1.1-bin.tar.gz | tar -xz -C /usr/local/

#alternative to the command above
#COPY hadoopclient/apache-hive-2.1.1-bin.tar.gz .
#RUN tar -xz -C /usr/local/ -f ./apache-hive-2.1.1-bin.tar.gz

RUN cd /usr/local && ln -s apache-hive-2.1.1-bin hive
COPY conf/hive-site.xml /usr/local/hive/conf
RUN echo "export HIVE_HOME=/usr/local/hive" >> /etc/profile
RUN echo "export PATH=$PATH:/usr/local/hive/bin">> /etc/profile
ENV HIVE_HOME /usr/local/hive
ENV PATH $PATH:$HIVE_HOME/bin
# Create directory for hive logs
RUN mkdir -p /var/log/hive
# Increase PermGen space for hiveserver2 to fix OOM pb.
COPY conf/hive-env.sh /usr/local/hive/conf/

RUN echo "HADOOP_HOME=/usr/local/hadoop" >> /usr/local/hive/bin/hive-config.sh

# Prepare spark-hive integration, so spark sql will use hive tables defined in hive metastore, see https://spark.apache.org/docs/1.6.0/sql-programming-guide.html#hive-tables
RUN cp $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml $SPARK_HOME/conf
RUN cp $HIVE_HOME/conf/hive-site.xml $SPARK_HOME/conf

RUN cp $HADOOP_PREFIX/etc/hadoop/core-site.xml $SPARK_HOME/conf
RUN echo spark.yarn.jar hdfs://hadoopservice/spark/spark-assembly-1.6.0-hadoop2.6.0.jar > $SPARK_HOME/conf/spark-defaults.conf

# Download mysql jdbc driver and prepare hive metastore.
RUN curl -s -o $HIVE_HOME/lib/mysql-connector-java-5.1.41.jar http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.41/mysql-connector-java-5.1.41.jar
RUN curl -s -o $HIVE_HOME/lib/mariadb-java-client-1.5.7.jar https://downloads.mariadb.com/Connectors/java/connector-java-1.5.7/mariadb-java-client-1.5.7.jar
# Make mysql driver available to kylo-spark-shell
RUN cp $HIVE_HOME/lib/mysql-connector-java-5.1.41.jar $SPARK_HOME/lib
RUN cp $HIVE_HOME/lib/mariadb-java-client-1.5.7.jar  $SPARK_HOME/lib
#TODO check this at runtime
RUN echo "spark.executor.extraClassPath $SPARK_HOME/lib/mysql-connector-java-5.1.41.jar" >> $SPARK_HOME/conf/spark-defaults.conf
RUN echo "spark.driver.extraClassPath $SPARK_HOME/lib/mysql-connector-java-5.1.41.jar" >> $SPARK_HOME/conf/spark-defaults.conf

