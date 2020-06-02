FROM       bd4c/hadoop_base
MAINTAINER Flip Kromer <flip@infochimps.com>, Russell Jurney

# Ports
#
EXPOSE 50070
EXPOSE 50470
EXPOSE 8020

# Install and configure the namenode
#
COPY img/hadoop_nn/hadoop-setup_nn.sh /build/
RUN         /build/hadoop-setup_nn.sh

# Config Files
#
COPY img/hadoop_base/conf/core-site.xml.mustache   $HADOOP_CONF_DIR/
COPY img/hadoop_base/conf/hdfs-site.xml.mustache   $HADOOP_CONF_DIR/
COPY img/hadoop_base/conf/yarn-site.xml.mustache   $HADOOP_CONF_DIR/
COPY img/hadoop_base/conf/mapred-site.xml.mustache $HADOOP_CONF_DIR/

# Ensures Hadoop directories are happy and permissioned even if we mount something under them.
COPY img/hadoop_nn/conf/init-hadoop_nn_fixup.sh /etc/my_init.d/30_hadoop_nn_fixup.sh

# Enable the service daemons
#
COPY img/hadoop_nn/runit/hadoop_nn-runner.sh /etc/sv/hadoop_nn/run
COPY img/hadoop_nn/runit/hadoop_nn-logger.sh /etc/sv/hadoop_nn/log/run
#
RUN  ln -s /etc/sv/hadoop_nn /etc/service/hadoop_nn

# Format the HDFS and make initial directories
#
COPY img/hadoop_nn/hadoop-bootstrap_hdfs.sh /build/
RUN         /build/hadoop-bootstrap_hdfs.sh
