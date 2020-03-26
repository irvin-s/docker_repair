FROM million12/centos-supervisor
LABEL name="zhuanxu <893051481@qq.com>"

# java
RUN yum clean all; \
    yum install -y wget which install less jq java-1.8.0-openjdk java-1.8.0-openjdk-devel openssh-server openssh-clients; \
    yum clean all; \
    rm -rf /var/cache/yum
ENV USER root




# hadoop
ADD hadoop-2.9.0.tar.gz /usr/local/
# RUN curl -s http://mirror.bit.edu.cn/apache/hadoop/common/stable/hadoop-2.9.0.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./hadoop-2.9.0 hadoop && rm -rf /usr/local/hadoop/share/doc

ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_LOG_DIR /mnt/hadoop/logs
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop


WORKDIR /usr/local/hadoop

RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/lib/jvm/java/\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh; \
    sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh; \
    chmod +x /usr/local/hadoop/etc/hadoop/*-env.sh; \
    mkdir -p /mnt/hadoop/dfs/name && mkdir -p /mnt/hadoop/dfs/data && mkdir -p /mnt/hadoop/journal/data && mkdir -p /mnt/hadoop/yarn/logs && mkdir /mnt/hadoop/logs

# ADD config/core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml.template
# ADD config/hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml.template
# ADD config/mapred-site.xml /usr/local/hadoop/etc/hadoop/mapred-site.xml.template
# ADD config/yarn-site.xml /usr/local/hadoop/etc/hadoop/yarn-site.xml.template
ADD config/core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml
ADD config/hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml
ADD config/mapred-site.xml /usr/local/hadoop/etc/hadoop/mapred-site.xml
ADD config/yarn-site.xml /usr/local/hadoop/etc/hadoop/yarn-site.xml


RUN echo 'export JAVA_HOME=/usr/lib/jvm/java/' >>  ~/.bashrc; \
    echo 'export PATH=$JAVA_HOME/bin:$PATH ' >> ~/.bashrc; \
    echo 'export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar ' >> ~/.bashrc; \
    source  ~/.bashrc; \
# ssh without key
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -P ''&& \
    ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -P '' && \
    ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -P '' && \
    mkdir -pv /var/log/supervisor/ && \
    cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys

ENV JAVA_HOME /usr/lib/jvm/java/
# 设置免密登录  
ADD config/ssh_config /etc/ssh/ssh_config
# RUN /usr/sbin/sshd
# 增加sshd服务启动
ADD etc/supervisor.d/sshd.conf /etc/supervisor.d/

VOLUME [ "/mnt/hadoop/" ]

# NameNode                Secondary NameNode  DataNode                     JournalNode  NFS Gateway    HttpFS         ZKFC
EXPOSE 8020 50070 50470   50090 50495         50010 1004 50075 1006 50020  8485 8480    2049 4242 111  14000 14001    8019


ENTRYPOINT ["/config/bootstrap.sh"]