FROM ubuntu:14.04

MAINTAINER thushear <lucas421634258@gmail.com>

RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list

WORKDIR /root

# install openssh-server, openjdk and wget
RUN apt-get update && apt-get install -y openssh-server openjdk-7-jdk wget vim  zip
# install hadoop 2.7.2
COPY   hadoop-2.5.0-cdh5.3.6.tar.gz  /tmp/
RUN   tar -xzvf /tmp/hadoop-2.5.0-cdh5.3.6.tar.gz -C /tmp/  && \
      rm  -rf /tmp/hadoop-2.5.0-cdh5.3.6/share/doc     && \
      mv /tmp/hadoop-2.5.0-cdh5.3.6 /usr/local/hadoop && \
      rm /tmp/hadoop-2.5.0-cdh5.3.6.tar.gz




COPY   hive-0.13.1-cdh5.3.6.tar.gz  /tmp/
RUN   tar -xzvf /tmp/hive-0.13.1-cdh5.3.6.tar.gz -C /tmp/  && \
      mv /tmp/hive-0.13.1-cdh5.3.6 /usr/local/hive && \
      rm /tmp/hive-0.13.1-cdh5.3.6.tar.gz

COPY   mysql-connector-java-5.1.27-bin.jar  /tmp/
RUN  mv /tmp/mysql-connector-java-5.1.27-bin.jar /usr/local/hive/lib

COPY   oozie-4.0.0-cdh5.3.6.tar.gz  /tmp/
RUN   tar -xzvf /tmp/oozie-4.0.0-cdh5.3.6.tar.gz -C /tmp/  && \
      mv /tmp/oozie-4.0.0-cdh5.3.6 /usr/local/oozie-4.0.0-cdh5.3.6 && \
      rm /tmp/oozie-4.0.0-cdh5.3.6.tar.gz
COPY   ext-2.2.zip  /tmp/

COPY   spark-1.3.0-bin-2.5.0-cdh5.3.6.tgz  /tmp/
RUN   tar -xzvf /tmp/spark-1.3.0-bin-2.5.0-cdh5.3.6.tgz -C /tmp/  && \
      mv /tmp/spark-1.3.0-bin-2.5.0-cdh5.3.6 /usr/local/spark-1.3.0-bin-2.5.0-cdh5.3.6 && \
      rm /tmp/spark-1.3.0-bin-2.5.0-cdh5.3.6.tgz




#RUN wget https://github.com/kiwenlau/compile-hadoop/releases/download/2.7.2/hadoop-2.7.2.tar.gz && \
#    tar -xzvf hadoop-2.7.2.tar.gz && \
#    mv hadoop-2.7.2 /usr/local/hadoop && \
#    rm hadoop-2.7.2.tar.gz



# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys


RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

COPY config/* /tmp/
COPY standalone/* /tmp/
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH /usr/local/hadoop/bin:/usr/local/hadoop/sbin:$PATH
RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/yarn-env.sh /usr/local/hadoop/etc/hadoop/yarn-env.sh && \
    mv /tmp/mapred-env.sh /usr/local/hadoop/etc/hadoop/mapred-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh && \
    mv /tmp/slaves /usr/local/spark-1.3.0-bin-2.5.0-cdh5.3.6/conf/slaves && \
    mv /tmp/spark-env.sh /usr/local/spark-1.3.0-bin-2.5.0-cdh5.3.6/conf/spark-env.sh && \
    mv /tmp/spark-defaults.conf /usr/local/spark-1.3.0-bin-2.5.0-cdh5.3.6/conf/spark-defaults.conf
COPY conf/* /tmp/
RUN mv /tmp/hive-env.sh /usr/local/hive/conf/hive-env.sh && \
    mv /tmp/hive-site.xml /usr/local/hive/conf/hive-site.xml && \
    mv /tmp/hive-log4j.properties /usr/local/hive/conf/hive-log4j.properties


RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh && \
    chmod +x $HADOOP_HOME/sbin/mr-jobhistory-daemon.sh  && \
    chmod +x /usr/local/hive/bin/hive


# set environment variable

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV PATH  /usr/lib/jvm/java-7-openjdk-amd64/bin:$PATH
RUN echo $JAVA_HOME
RUN echo $HADOOP_HOME
RUN echo $PATH
# format namenode
#RUN /usr/local/hadoop/bin/hdfs namenode -format
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
#CMD [ "sh", "-c", "service ssh start; bash"]

