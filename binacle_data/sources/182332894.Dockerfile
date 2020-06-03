FROM       bd4c/hadoop_base
MAINTAINER Flip Kromer <flip@infochimps.com>, Russell Jurney

# Ports
#
EXPOSE 50090
EXPOSE 50490

# Install and configure the secondarynamenode
#
COPY img/hadoop_snn/hadoop-setup_snn.sh /build/
RUN          /build/hadoop-setup_snn.sh

# Config Files
#
COPY img/hadoop_base/conf/core-site.xml.mustache   $HADOOP_CONF_DIR/
COPY img/hadoop_base/conf/hdfs-site.xml.mustache   $HADOOP_CONF_DIR/
COPY img/hadoop_base/conf/yarn-site.xml.mustache   $HADOOP_CONF_DIR/
COPY img/hadoop_base/conf/mapred-site.xml.mustache $HADOOP_CONF_DIR/

# Ensures Hadoop directories are happy and permissioned even if we mount something under them.
COPY img/hadoop_snn/conf/init-hadoop_snn_fixup.sh /etc/my_init.d/30_hadoop_snn_fixup.sh

# Enable the service daemons
#
COPY img/hadoop_snn/runit/hadoop_snn-runner.sh /etc/sv/hadoop_snn/run
COPY img/hadoop_snn/runit/hadoop_snn-logger.sh /etc/sv/hadoop_snn/log/run
#
RUN ln -s /etc/sv/hadoop_snn /etc/service/hadoop_snn
