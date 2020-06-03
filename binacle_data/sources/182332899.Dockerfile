FROM       bd4c/hadoop_base
MAINTAINER Flip Kromer <flip@infochimps.com>, Russell Jurney

ENV HADOOP_NN_HOSTNAME solo
ENV HADOOP_RM_HOSTNAME solo

ENV HADOOP_CONF_DIR    /etc/hadoop/conf.single
# Get our own set of conf files
RUN \
  cp -rp  /etc/hadoop/conf.empty $HADOOP_CONF_DIR && \
  update-alternatives --install /etc/hadoop/conf hadoop-conf $HADOOP_CONF_DIR 50 && \
  update-alternatives --set                      hadoop-conf $HADOOP_CONF_DIR

# Ports
#
# are you ready to see a really long list of ports?
#
# NN: console 50070 ipc 8020
EXPOSE 50070
EXPOSE 8020
#
# snn 50090
#
EXPOSE 50090
# 
# rsrc mgr: console http 8088 / https 8090; scheduler 8030;
#           tracker 8031; ipc 8032; admin 8033; ganglia 8660, shuffle 13562;
# history:  console 19888 / https 19890, ipc 10020, admin 1033
EXPOSE 8088
EXPOSE 8030
EXPOSE 8031
EXPOSE 8032
EXPOSE 8033
EXPOSE 13562
EXPOSE 19888
EXPOSE 10020
EXPOSE 1033
#
# datanode: console http 50075 / https 50475; ipc 50020 ; xceiver 50010; jmx 8010
# nodemgr:  console http 8042  / https 8044;  ipc 8041  ; localizer 8040
EXPOSE 50075
EXPOSE 50020
EXPOSE 50010
EXPOSE 8010
EXPOSE 8042
EXPOSE 8040
EXPOSE 8041

# Install and configure the namenode
COPY img/hadoop_nn/hadoop-setup_nn.sh /build/
RUN         /build/hadoop-setup_nn.sh
# Install and configure the datanode
COPY img/hadoop_worker/hadoop-setup_dn.sh /build/
RUN             /build/hadoop-setup_dn.sh
# Install and configure the nodemanager
COPY img/hadoop_worker/hadoop-setup_nm.sh /build/
RUN             /build/hadoop-setup_nm.sh
# Install and configure the secondarynamenode
COPY img/hadoop_snn/hadoop-setup_snn.sh /build/
RUN          /build/hadoop-setup_snn.sh
# Install and configure the resourcemanager and historyserver
COPY img/hadoop_rm/hadoop-setup_rm.sh /build/
RUN         /build/hadoop-setup_rm.sh

# Config Files
#
COPY img/hadoop_base/conf/core-site.xml.mustache   $HADOOP_CONF_DIR/
COPY img/hadoop_base/conf/hdfs-site.xml.mustache   $HADOOP_CONF_DIR/
COPY img/hadoop_base/conf/yarn-site.xml.mustache   $HADOOP_CONF_DIR/
COPY img/hadoop_base/conf/mapred-site.xml.mustache $HADOOP_CONF_DIR/

# Ensures Hadoop directories are happy and permissioned even if we mount something under them.
COPY img/hadoop_nn/conf/init-hadoop_nn_fixup.sh         /etc/my_init.d/30_hadoop_nn_fixup.sh
COPY img/hadoop_snn/conf/init-hadoop_snn_fixup.sh       /etc/my_init.d/30_hadoop_snn_fixup.sh
COPY img/hadoop_rm/conf/init-hadoop_rm_fixup.sh         /etc/my_init.d/30_hadoop_rm_fixup.sh
COPY img/hadoop_worker/conf/init-hadoop_worker_fixup.sh /etc/my_init.d/30_hadoop_worker_fixup.sh

# Enable the service daemons
#
COPY img/hadoop_nn/runit/hadoop_nn-runner.sh /etc/sv/hadoop_nn/run
COPY img/hadoop_nn/runit/hadoop_nn-logger.sh /etc/sv/hadoop_nn/log/run
RUN  ln -s /etc/sv/hadoop_nn /etc/service/hadoop_nn
#
COPY img/hadoop_worker/runit/hadoop_dn-runner.sh /etc/sv/hadoop_dn/run
COPY img/hadoop_worker/runit/hadoop_dn-logger.sh /etc/sv/hadoop_dn/log/run
COPY img/hadoop_worker/runit/hadoop_nm-runner.sh /etc/sv/hadoop_nm/run
COPY img/hadoop_worker/runit/hadoop_nm-logger.sh /etc/sv/hadoop_nm/log/run
RUN  ln -s /etc/sv/hadoop_dn /etc/service/hadoop_dn
RUN  ln -s /etc/sv/hadoop_nm /etc/service/hadoop_nm
#
COPY img/hadoop_snn/runit/hadoop_snn-runner.sh /etc/sv/hadoop_snn/run
COPY img/hadoop_snn/runit/hadoop_snn-logger.sh /etc/sv/hadoop_snn/log/run
RUN ln -s /etc/sv/hadoop_snn /etc/service/hadoop_snn
#
COPY img/hadoop_rm/runit/hadoop_rm-runner.sh   /etc/sv/hadoop_rm/run
COPY img/hadoop_rm/runit/hadoop_rm-logger.sh   /etc/sv/hadoop_rm/log/run
COPY img/hadoop_rm/runit/hadoop_hist-runner.sh /etc/sv/hadoop_hist/run
COPY img/hadoop_rm/runit/hadoop_hist-logger.sh /etc/sv/hadoop_hist/log/run
RUN  ln -s /etc/sv/hadoop_rm   /etc/service/hadoop_rm
RUN  ln -s /etc/sv/hadoop_hist /etc/service/hadoop_hist

# Format the HDFS and make initial directories
#
COPY img/hadoop_nn/hadoop-bootstrap_hdfs.sh /build/
RUN         /build/hadoop-bootstrap_hdfs.sh
