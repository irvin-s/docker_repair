FROM dcapwell/base:0.2

RUN mkdir -p /opt/hadoop
RUN cd /opt/hadoop && wget 'http://mirrors.koehn.com/apache/hadoop/common/hadoop-2.4.1/hadoop-2.4.1.tar.gz' && tar zxvf hadoop-2.4.1.tar.gz && rm hadoop-2.4.1.tar.gz

ADD configs /opt/hadoop/hadoop-2.4.1/etc/hadoop/

RUN /opt/hadoop/hadoop-2.4.1/bin/hdfs namenode -format

ADD start-all.sh /opt/hadoop/hadoop-2.4.1/

ENV HADOOP_CONF_DIR   /opt/hadoop/hadoop-2.4.1/etc/hadoop/
ENV YARN_CONF_DIR     /opt/hadoop/hadoop-2.4.1/etc/hadoop/
