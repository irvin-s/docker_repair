# Daniel Malczyk
# ThinkBig Analytics, a Teradata Company

#image for a separate Hadoop/Spark container for Kylo
FROM airhacks/java

MAINTAINER Daniel Malczyk <dmalczyk@gmail.com>

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync mysql; \
    yum clean all
# update libselinux. see https://github.com/sequenceiq/hadoop-docker/issues/14
RUN yum update -y libselinux

# passwordless ssh
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# download native support
RUN mkdir -p /tmp/native
RUN curl -L https://github.com/sequenceiq/docker-hadoop-build/releases/download/v2.7.1/hadoop-native-64-2.7.1.tgz | tar -xz -C /tmp/native

#Install hadoop to /usr/local/hadoop
RUN curl -s http://www.eu.apache.org/dist/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./hadoop-2.7.1 hadoop

ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_INSTALL $HADOOP_HOME
ENV HADOOP_PREFIX $HADOOP_HOME
ENV PATH $PATH:$HADOOP_INSTALL/sbin
ENV HADOOP_MAPRED_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_HOME $HADOOP_INSTALL
ENV HADOOP_HDFS_HOME $HADOOP_INSTALL
ENV YARN_HOME $HADOOP_INSTALL
ENV PATH $HADOOP_HOME/bin:$PATH

RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/etc/alternatives/java_sdk\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

RUN mkdir $HADOOP_PREFIX/input
RUN cp $HADOOP_PREFIX/etc/hadoop/*.xml $HADOOP_PREFIX/input

# pseudo distributed
COPY conf/core-site.xml.template2 $HADOOP_PREFIX/etc/hadoop/
RUN sed s/HOSTNAME/localhost/ /usr/local/hadoop/etc/hadoop/core-site.xml.template2 > /usr/local/hadoop/etc/hadoop/core-site.xml
ADD conf/hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml

ADD conf/mapred-site.xml $HADOOP_PREFIX/etc/hadoop/mapred-site.xml
ADD conf/yarn-site.xml $HADOOP_PREFIX/etc/hadoop/yarn-site.xml

RUN $HADOOP_PREFIX/bin/hdfs namenode -format

# fixing the libhadoop.so like a boss
RUN rm -rf /usr/local/hadoop/lib/native
RUN mv /tmp/native /usr/local/hadoop/lib

ADD conf/ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

# workingaround docker.io build error
RUN ls -la /usr/local/hadoop/etc/hadoop/*-env.sh
RUN chmod +x /usr/local/hadoop/etc/hadoop/*-env.sh
RUN ls -la /usr/local/hadoop/etc/hadoop/*-env.sh

# fix the 254 error code
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config
RUN echo "Port 2122" >> /etc/ssh/sshd_config

RUN /usr/sbin/sshd && $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /user/root
RUN /usr/sbin/sshd && $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfs -put $HADOOP_PREFIX/etc/hadoop/ input

#Install spark to /usr/local/spark
#support for Hadoop 2.6.0
RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-1.6.1-bin-hadoop2.6 spark
ENV SPARK_HOME /usr/local/spark

ENV PATH $SPARK_HOME/bin:$PATH

# add spark and hadoop path to PATH env variable for kylo user
RUN echo "export PATH=$PATH:/usr/java/default/bin:/usr/local/spark/bin:/usr/local/hadoop/bin" >> /etc/profile

# Install hive
RUN curl -s http://apache.mirrors.spacedump.net/hive/hive-2.1.1/apache-hive-2.1.1-bin.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s apache-hive-2.1.1-bin hive
COPY conf/hive-site.xml /usr/local/hive/conf
RUN echo "export HIVE_HOME=/usr/local/hive" >> /etc/profile
RUN echo "export PATH=$PATH:/usr/local/hive/bin">> /etc/profile
ENV HIVE_HOME /usr/local/hive
ENV PATH $PATH:$HIVE_HOME/bin
# Create directory for hive logs
RUN mkdir -p /var/log/hive
# Increase PermGen space for hiveserver2 to fix OOM pb.
COPY conf/hive-env.sh /usr/local/hive/conf/

RUN echo "HADOOP_HOME=/usr/local/hadoop" >> /usr/local/hive/bin/hive-config.sh

# Download mysql jdbc driver and prepare hive metastore.
RUN curl -s -o /usr/local/apache-hive-2.1.1-bin/lib/mysql-connector-java-5.1.41.jar http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.41/mysql-connector-java-5.1.41.jar

# create hiveserver2 service
COPY conf/hive-server2 /etc/init.d/
RUN chmod +x /etc/init.d/hive-server2
#RUN chkconfig --add /etc/init.d/hive-server2
# ---- Hive installation finished -------

# Prepare spark-hive integration, so spark sql will use hive tables defined in hive metastore, see https://spark.apache.org/docs/1.6.0/sql-programming-guide.html#hive-tables
RUN cp /usr/local/hadoop/etc/hadoop/hdfs-site.xml /usr/local/spark/conf
RUN cp /usr/local/hive/conf/hive-site.xml /usr/local/spark/conf
RUN cp /usr/local/hive/lib/mysql-connector-java-5.1.41.jar /usr/local/spark/lib
# ----- Spark-Hive integration finished ---------


# create nifi user and group
RUN /bin/bash -c 'useradd -r -m -s /bin/bash nifi'
# create kylo user and group
RUN /bin/bash -c 'useradd -r -m -s /bin/bash kylo'
# Add kylo and nifi user to supergroup otherwise kylo-spark-shell service which runs as kylo user will not be able to create database in hive.
RUN groupadd supergroup
RUN usermod -a -G supergroup kylo
RUN usermod -a -G supergroup nifi

COPY scripts/hadoop_bootstrap.sh /etc/hadoop_bootstrap.sh
RUN chown root.root /etc/hadoop_bootstrap.sh
RUN chmod 700 /etc/hadoop_bootstrap.sh

ENV BOOTSTRAP /etc/hadoop_bootstrap.sh

ENTRYPOINT ["/etc/hadoop_bootstrap.sh"]

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
EXPOSE 10020 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 2122
#Hive
EXPOSE 10000
#Spark
EXPOSE 8450 8451 4040