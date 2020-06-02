# Creates pseudo distributed hadoop 2.4 running giraph
#
# docker build -t uwsampa/giraph .

FROM sequenceiq/hadoop-docker:2.4.1
MAINTAINER uwsampa

USER root

# install software
ADD giraph-setup.sh /etc/giraph-setup.sh
RUN chown root:root /etc/giraph-setup.sh && chmod 700 /etc/giraph-setup.sh && /etc/giraph-setup.sh

# set home variables
ENV HADOOP_HOME $HADOOP_PREFIX
ENV HADOOP_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV GIRAPH_HOME /usr/local/giraph
ENV GIRAPH_PREFIX /usr/local/giraph
ENV ZOOKEEPER_HOME /usr/local/zookeeper
ENV ZOOKEEPER_PREFIX /usr/local/zookeeper

# add zookeeper configuration
ADD zoo.cfg $ZOOKEEPER_PREFIX/conf/zoo.cfg

# add sample intput
ADD tiny-graph.txt $GIRAPH_PREFIX/tiny-graph.txt

# our bootstrap file
ADD giraph-bootstrap.sh /etc/giraph-bootstrap.sh
RUN chown root:root /etc/giraph-bootstrap.sh && chmod 700 /etc/giraph-bootstrap.sh

# default command
CMD ["/etc/giraph-bootstrap.sh", "-d"]
