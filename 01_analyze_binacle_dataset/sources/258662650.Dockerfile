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



# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys


RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

COPY config/* /tmp/
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
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh


RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh && \
    chmod +x $HADOOP_HOME/sbin/mr-jobhistory-daemon.sh



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

