FROM dckreg:5000/spark-base:{{ SPARK_VERSION }}

COPY spark-daemon.sh $SPARK_HOME/sbin/
COPY startspark.sh $SPARK_HOME/sbin/

COPY core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
COPY hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml

RUN chown -R  spark $SPARK_HOME

ENV SPARK_MASTER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"

ENV SPARK_WORKER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"

