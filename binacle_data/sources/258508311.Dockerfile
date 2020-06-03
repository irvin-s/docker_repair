FROM openjdk:8-jre

ENV HADOOP_VERSION    2.7.0
ENV HADOOP_HOME        /opt/hadoop
ENV HADOOP_OPTS        -Djava.library.path=$HADOOP_HOME/lib/native
ENV PATH        $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

RUN DEBIAN_FRONTEND=noninteractive   && \
    wget http://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
    tar xvf hadoop-$HADOOP_VERSION.tar.gz && \
    rm /hadoop-$HADOOP_VERSION.tar.gz && \
    mv hadoop-$HADOOP_VERSION $HADOOP_HOME 

RUN useradd -u 9000 -m hdfs

COPY core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
COPY hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml

COPY core-site.xml.template core-site.xml.template
COPY hdfs-site.xml.template hdfs-site.xml.template

COPY starthdfs.sh $HADOOP_HOME/bin/starthdfs.sh

RUN chmod 755 $HADOOP_HOME/bin/starthdfs.sh
RUN chown -R hdfs $HADOOP_HOME

USER hdfs

CMD ["starthdfs.sh"]
