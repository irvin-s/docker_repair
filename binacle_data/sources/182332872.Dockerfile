FROM       bd4c/hadoop_base
MAINTAINER Flip Kromer <flip@infochimps.com>, Russell Jurney

# 
ENV  HADOOP_EXAMPLES_JAR /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar
ENV  HUE_CONF_DIR        /etc/hue/conf.cluster
ENV  HUE_HOME            /usr/lib/hue
ENV  HUE_DATA_DIR        /bulk/hadoop/hue
ENV  HADOOP_HIVE_HOSTNAME lounge

# Configure Hadoop client
#
COPY img/hadoop_lounge/hadoop-setup_client.sh  /build/
RUN             /build/hadoop-setup_client.sh

# Config files for my_init/mustache_rider.sh to prepare
# 
COPY img/hadoop_lounge/conf/hue.ini.mustache $HUE_CONF_DIR/

# Install and configure Hue.
#
COPY img/hadoop_lounge/hadoop-setup_hue.sh  /build/
RUN             /build/hadoop-setup_hue.sh

# Make a user account named 'chimpy'
# (done in hadoop_base for now)
# COPY img/hadoop_lounge/conf/bashrc          /home/chimpy/.bashrc
# COPY img/hadoop_lounge/conf/README.md       /home/chimpy/
# COPY img/hadoop_lounge/add_chimpy_user.sh   /build/
# RUN             /build/add_chimpy_user.sh

# Copy the hue config scripts and enable the servise
#
COPY img/hadoop_lounge/runit/hadoop_hue-runner.sh /etc/sv/hadoop_hue/run
COPY img/hadoop_lounge/runit/hadoop_hue-logger.sh /etc/sv/hadoop_hue/log/run
#
RUN  ln -s /etc/sv/hadoop_hue /etc/service/hadoop_hue
#

# ENTRYPOINT ["/usr/bin/runsvdir", "-P", "/etc/service"]
