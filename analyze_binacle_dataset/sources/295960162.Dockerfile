FROM trex/base:latest
MAINTAINER xenron <xenron@hotmail.com>

# move all configuration files into container
ADD files/* /usr/local/

# install hadoop 2.7.5
RUN wget -q -o out.log -P /tmp https://archive.apache.org/dist/hadoop/common/hadoop-2.7.5/hadoop-2.7.5.tar.gz && \
  tar xzf /tmp/hadoop-2.7.5.tar.gz -C /opt && \
  rm /tmp/hadoop-2.7.5.tar.gz && \
  mv /opt/hadoop-2.7.5 /opt/hadoop && \
  mv /usr/local/bashrc ~/.bashrc && \
  mv /usr/local/hadoop-env.sh /opt/hadoop/etc/hadoop/hadoop-env.sh

# install hive 2.1.1
RUN wget -q -o out.log -P /tmp https://archive.apache.org/dist/hive/hive-2.1.1/apache-hive-2.1.1-bin.tar.gz && \
  tar xzf /tmp/apache-hive-2.1.1-bin.tar.gz -C /opt && \
  rm /tmp/apache-hive-2.1.1-bin.tar.gz && \
  mv /opt/apache-hive-2.1.1-bin /opt/hive


