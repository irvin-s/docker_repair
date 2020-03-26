FROM       bd4c/baseimage
MAINTAINER Flip Kromer <flip@infochimps.com>, Russell Jurney

#
# Environment
#

ENV HADOOP_APT_VERSION precise-cdh5.2.0

# Centralize the interesting directories so their lifecycle can be tracked
# separately from the machine image by mounting volumes
ENV HADOOP_BULK_DIR  /bulk/hadoop
ENV ZK_BULK_DIR      /bulk/zookeeper

# Specific directories for hadoop and zookeeper
ENV HADOOP_TMP_DIR   $HADOOP_BULK_DIR/tmp
ENV HADOOP_LOG_DIR   $HADOOP_BULK_DIR/log
ENV ZK_DB_DIR        $ZK_BULK_DIR/db
ENV ZK_JOURNAL_DIR   $ZK_BULK_DIR/txlog
ENV ZK_LOG_DIR       $ZK_BULK_DIR/log

ENV HADOOP_NN_HOSTNAME nn
ENV HADOOP_RM_HOSTNAME rm

# Hadoop config stored here, and linked as the standard /etc/hadoop/conf
ENV HADOOP_CONF_DIR /etc/hadoop/conf.cluster

# ---------------------------------------------------------------------------
#
# Install
#

# Construct the hadoop users
COPY img/hadoop_base/hadoop-add_users.sh    /build/
RUN           /build/hadoop-add_users.sh

# Adding the chimpy user to all machines for now
COPY img/hadoop_lounge/add_chimpy_user.sh   /build/
RUN             /build/add_chimpy_user.sh
COPY img/hadoop_lounge/conf/bashrc          /home/chimpy/.bashrc
COPY img/hadoop_lounge/conf/README.md       /home/chimpy/

# Install and configure Hadoop & Zookeeper components common to all images
COPY img/hadoop_base/hadoop-setup_common.sh /build/
RUN           /build/hadoop-setup_common.sh

COPY img/hadoop_base/conf/core-site.xml.mustache   $HADOOP_CONF_DIR/
COPY img/hadoop_base/conf/hdfs-site.xml.mustache   $HADOOP_CONF_DIR/
COPY img/hadoop_base/conf/yarn-site.xml.mustache   $HADOOP_CONF_DIR/
COPY img/hadoop_base/conf/mapred-site.xml.mustache $HADOOP_CONF_DIR/

# Update configs on each container start
COPY img/hadoop_base/conf/mustache_rider.sh  /etc/my_init.d/50_hadoop_mustache_rider.sh

RUN /etc/my_init.d/50_hadoop_mustache_rider.sh
RUN colordiff -uw $HADOOP_CONF_DIR/core-site.xml.mustache $HADOOP_CONF_DIR/core-site.xml ; true

# TODO figure this out
# ONBUILD RUN img/baseimage/cleanup.sh
