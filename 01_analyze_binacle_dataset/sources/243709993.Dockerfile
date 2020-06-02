FROM karlstoney/jvm:latest 

RUN yum -y -q install perl which

ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_CONF_DIR /etc/hadoop
ENV HADOOP_PREFIX $HADOOP_HOME

ENV MULTIHOMED_NETWORK 1
ENV PATH $HADOOP_HOME/bin/:$PATH

# GET Hadoop
ENV HADOOP_VERSION 2.7.3
ENV HADOOP_DIST https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN curl --silent -fSL "$HADOOP_DIST" -o /tmp/hadoop.tar.gz && \
    tar -xf /tmp/hadoop.tar.gz -C /opt/ && \
    rm -f /tmp/hadoop.tar.gz && \
    mv /opt/hadoop-* $HADOOP_HOME
 
RUN mkdir $HADOOP_HOME/logs
RUN mkdir /hadoop-data

RUN ln -s $HADOOP_HOME/etc/hadoop /etc/hadoop
RUN cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
