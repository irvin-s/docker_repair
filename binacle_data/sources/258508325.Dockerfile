FROM openjdk:8-jre

ENV SPARK_VERSION      2.0.0
ENV SPARK_BIN_VERSION  $SPARK_VERSION-bin-hadoop2.7
ENV SPARK_HOME         /opt/spark
ENV PATH               $PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# Installing Spark for Hadoop
RUN wget http://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_BIN_VERSION.tgz && \
    tar -zxf /spark-$SPARK_BIN_VERSION.tgz  && \
    mv spark-$SPARK_BIN_VERSION $SPARK_HOME && \
    rm /spark-$SPARK_BIN_VERSION.tgz

RUN apt-get update
RUN apt-get -y install python

RUN useradd -u 9000 -m spark 

COPY spark-daemon.sh $SPARK_HOME/sbin/
COPY startspark.sh $SPARK_HOME/sbin/

RUN chown -R  spark $SPARK_HOME

USER spark

ENV SPARK_MASTER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"

ENV SPARK_WORKER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"

CMD ["startspark.sh"]
