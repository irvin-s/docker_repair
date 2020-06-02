#
# Dockerfile - Apache Hadoop
#
FROM     ubuntu:14.04
MAINTAINER Yongbok Kim <ruo91@yongbok.net>

# Last Package Update & Install
RUN apt-get update && apt-get install -y curl supervisor openssh-server net-tools iputils-ping nano

# JDK
ENV JDK_URL http://download.oracle.com/otn-pub/java/jdk
ENV JDK_VER 8u91-b14
ENV JDK_VER2 jdk-8u91
ENV JAVA_HOME /usr/local/jdk
ENV PATH $PATH:$JAVA_HOME/bin
RUN cd $SRC_DIR && curl -LO "$JDK_URL/$JDK_VER/$JDK_VER2-linux-x64.tar.gz" -H 'Cookie: oraclelicense=accept-securebackup-cookie' \
 && tar xzf $JDK_VER2-linux-x64.tar.gz && mv jdk1* $JAVA_HOME && rm -f $JDK_VER2-linux-x64.tar.gz \
 && echo '' >> /etc/profile \
 && echo '# JDK' >> /etc/profile \
 && echo "export JAVA_HOME=$JAVA_HOME" >> /etc/profile \
 && echo 'export PATH="$PATH:$JAVA_HOME/bin"' >> /etc/profile \
 && echo '' >> /etc/profile

# Apache Hadoop
ENV SRC_DIR /opt
ENV HADOOP_URL http://www.eu.apache.org/dist/hadoop/common
ENV HADOOP_VERSION hadoop-2.7.2
RUN cd $SRC_DIR && curl -LO "$HADOOP_URL/$HADOOP_VERSION/$HADOOP_VERSION.tar.gz" \
 && tar xzf $HADOOP_VERSION.tar.gz ; rm -f $HADOOP_VERSION.tar.gz

# Hadoop ENV
ENV HADOOP_PREFIX $SRC_DIR/$HADOOP_VERSION
ENV PATH $PATH:$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin
ENV HADOOP_MAPRED_HOME $HADOOP_PREFIX
ENV HADOOP_COMMON_HOME $HADOOP_PREFIX
ENV HADOOP_HDFS_HOME $HADOOP_PREFIX
ENV YARN_HOME $HADOOP_PREFIX
RUN echo '# Hadoop' >> /etc/profile \
 && echo "export HADOOP_PREFIX=$HADOOP_PREFIX" >> /etc/profile \
 && echo 'export PATH=$PATH:$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin' >> /etc/profile \
 && echo 'export HADOOP_MAPRED_HOME=$HADOOP_PREFIX' >> /etc/profile \
 && echo 'export HADOOP_COMMON_HOME=$HADOOP_PREFIX' >> /etc/profile \
 && echo 'export HADOOP_HDFS_HOME=$HADOOP_PREFIX' >> /etc/profile \
 && echo 'export YARN_HOME=$HADOOP_PREFIX' >> /etc/profile

# Add in the etc/hadoop directory
ADD conf/core-site.xml $HADOOP_PREFIX/etc/hadoop/core-site.xml
ADD conf/hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml
ADD conf/yarn-site.xml $HADOOP_PREFIX/etc/hadoop/yarn-site.xml
ADD conf/mapred-site.xml $HADOOP_PREFIX/etc/hadoop/mapred-site.xml
RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/local/jdk:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

# SSH keygen
RUN cd /root && ssh-keygen -t dsa -P '' -f "/root/.ssh/id_dsa" \
 && cat /root/.ssh/id_dsa.pub >> /root/.ssh/authorized_keys && chmod 644 /root/.ssh/authorized_keys

# Name node foramt
RUN hdfs namenode -format

# Supervisor
RUN mkdir -p /var/log/supervisor
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/without-password/yes/g' /etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN echo 'SSHD: ALL' >> /etc/hosts.allow

# Root password
RUN echo 'root:hadoop' |chpasswd

# Port
# Node Manager: 8042, Resource Manager: 8088, NameNode: 50070, DataNode: 50075, SecondaryNode: 50090
EXPOSE 22 8042 8088 50070 50075 50090

# Daemon
CMD ["/usr/bin/supervisord"]
