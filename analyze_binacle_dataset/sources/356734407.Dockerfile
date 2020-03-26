###########################################
## Spark 1.4.1 over Hadoop 2.6 over Ubuntu

FROM sequenceiq/hadoop-ubuntu:2.6.0
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

###########################################
# From http://www.eu.apache.org/dist/spark/spark-1.4.1/
ENV SPARK_VERSION spark-1.4.1
ENV HADOOP_VERSION hadoop2.6
ENV SPARK_BIN "$SPARK_VERSION-bin-$HADOOP_VERSION"
ENV SPARK_URL "http://www.eu.apache.org/dist/spark/$SPARK_VERSION/$SPARK_BIN.tgz"

###########################################
# Spark
RUN curl $SPARK_URL | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s $SPARK_BIN spark
ENV SPARK_HOME /usr/local/spark
# HDFS with spark libs
RUN service ssh start && \
    $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && \
    $HADOOP_PREFIX/sbin/start-dfs.sh && \
    $HADOOP_PREFIX/bin/hdfs dfsadmin -safemode leave && \
    $HADOOP_PREFIX/bin/hdfs dfs -put $SPARK_HOME/lib /spark

###########################################
ENV SPARK_JAR hdfs:///spark/$SPARK_BIN.jar
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin
RUN echo "spark.master\tspark://master:7077" \
    > $SPARK_HOME/conf/spark-defaults.conf

###########################################
# This is necessary to make things work in a cluster
# where slave datanodes will search for
ENV MYHOSTNAME master
# Set the right name for configuration
RUN sed "s/HOSTNAME/$MYHOSTNAME/" \
    $HADOOP_PREFIX/etc/hadoop/core-site.xml.template > \
    $HADOOP_PREFIX/etc/hadoop/core-site.xml
# Bootstraps for master and workers
ENV BSMASTER /bootmaster.sh
# sed -i.bak 's/value>1/value>0/'g $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml
# yes Y | hdfs namenode -format
RUN echo "#!/bin/bash" > $BSMASTER && \
    echo "spark-class org.apache.spark.deploy.master.Master &\nsleep 5" \
        >> $BSMASTER && \
    echo "echo 'starting namenode'" >> $BSMASTER && \
    echo "hdfs namenode > /dev/null 2>&1 &\nsleep 5" >> $BSMASTER && \
    echo "echo 'starting secondary namenode'" >> $BSMASTER && \
    echo "hdfs secondarynamenode > /dev/null 2>&1 &\nsleep 5" >> $BSMASTER && \
    echo "echo 'starting datanode'" >> $BSMASTER && \
    echo "hdfs dfsadmin -safemode leave && hdfs datanode > /dev/null 2>&1" \
        >> $BSMASTER
# service ssh start && $HADOOP_PREFIX/sbin/start-dfs.sh
# hdfs dfsadmin -safemode leave
ENV BSWORKER /bootslave.sh
RUN echo "#!/bin/bash" > $BSWORKER && \
    echo "spark-class org.apache.spark.deploy.worker.Worker spark://master:7077" >> $BSWORKER
RUN chmod +x $BSWORKER $BSMASTER

#EXPOSE 7077
#CMD ["$BSMASTER"]

###########################################
# WORKER test operation
# hdfs dfs -put /data/books/pg1232.txt hdfs://master:9000/mybook.txt
