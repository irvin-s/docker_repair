FROM dckreg:5000/hadoop:2.7.3

COPY core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
COPY hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml

COPY namenode.sh $HADOOP_HOME/bin/namenode.sh
COPY datanode.sh $HADOOP_HOME/bin/datanode.sh

RUN chmod 755 $HADOOP_HOME/bin/namenode.sh
RUN chmod 755 $HADOOP_HOME/bin/datanode.sh
RUN chown -R hdfs $HADOOP_HOME

