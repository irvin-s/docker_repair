FROM karlstoney/jvm:latest

# Get HBase 
ENV HBASE_VERSION 1.3.0
ENV HBASE_DIST http://mirrors.ukfast.co.uk/sites/ftp.apache.org/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz   
ENV HBASE_HOME /opt/hbase
ENV PATH $HBASE_HOME/bin/:$PATH

RUN curl --silent -fSL "$HBASE_DIST" -o /tmp/hbase.tar.gz && \
    tar -xf /tmp/hbase.tar.gz -C /opt/ && \
    rm -f /tmp/hbase.tar.gz && \
    mv /opt/hbase-* $HBASE_HOME 

# GET Hadoop
ENV HADOOP_VERSION 2.7.3
ENV HADOOP_DIST https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
ENV HADOOP_HOME /opt/hadoop
ENV PATH $HADOOP_HOME/bin/:$PATH

RUN curl --silent -fSL "$HADOOP_DIST" -o /tmp/hadoop.tar.gz && \
    tar -xf /tmp/hadoop.tar.gz -C /opt/ && \
    rm -f /tmp/hadoop.tar.gz && \
    mv /opt/hadoop-* $HADOOP_HOME

# Get Flume
ENV FLUME_VERSION 1.7.0
ENV FLUME_HOME /opt/flume
ENV FLUME_DIST http://www.eu.apache.org/dist/flume/$FLUME_VERSION/apache-flume-$FLUME_VERSION-bin.tar.gz
ENV PATH $FLUME_HOME/bin/:$PATH

RUN curl --silent -fSL "$FLUME_DIST" -o /tmp/flume.tar.gz && \
    tar -xf /tmp/flume.tar.gz -C /opt/ && \
    rm /tmp/flume.tar.gz && \
	mv /opt/apache-flume-* $FLUME_HOME 

RUN mv $FLUME_HOME/conf/flume-conf.properties.template $FLUME_HOME/
COPY log4j.properties $FLUME_HOME/

RUN yes | cp -f $HBASE_HOME/lib/*.jar $FLUME_HOME/lib/

VOLUME ["/opt/flume/conf"]

ADD run.sh /usr/local/bin/run.sh
CMD ["/usr/local/bin/run.sh"]
