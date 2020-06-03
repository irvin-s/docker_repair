FROM dckreg:5000/hbase-base:{{ HBASE_VERSION }}


COPY core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
COPY hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml

COPY hbase-site.xml  $HBASE_HOME/conf/hbase-site.xml
COPY starthbase.sh $HBASE_HOME/bin/starthbase.sh

