# sudo docker build -t dreamlab/goffish3-hama-base .

FROM tianon/centos:6.5
MAINTAINER dreamlab

USER root

# install dev tools
RUN yum install -y curl which tar git sudo openssh-server openssh-clients rsync | true && \
    yum update -y libselinux | true && \
    yum install dnsmasq snappy openssl vim bind-utils -y && \
    ln -s /usr/lib64/libcrypto.so.1.0.1e /usr/lib64/libcrypto.so && \ 
    echo source /etc/bashrc > /root/.bash_profile && \
    echo user=root >> /etc/dnsmasq.conf && \
    echo bogus-priv >> /etc/dnsmasq.conf && \
    echo interface=eth0 >> /etc/dnsmasq.conf && \
    echo no-dhcp-interface=eth0 >> /etc/dnsmasq.conf

# passwordless ssh
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# java

RUN yum install -y java-1.8.0-openjdk-devel;yum clean all 

# hadoop
ADD hadoop-2.7.1.tar.gz /usr/local/
RUN cd /usr/local && ln -s ./hadoop-2.7.1 hadoop && \
    rm  /usr/local/hadoop/lib/native/*

# fixing the libhadoop.so like a boss
ADD hadoop-native-64-2.7.1.tar /usr/local/hadoop/lib/native/

ENV HADOOP_PREFIX=/usr/local/hadoop \
    HADOOP_COMMON_HOME=/usr/local/hadoop \
    HADOOP_HDFS_HOME=/usr/local/hadoop \
    HADOOP_MAPRED_HOME=/usr/local/hadoop \
    HADOOP_YARN_HOME=/usr/local/hadoop \
    HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop \
    YARN_CONF_DIR=$HADOOP_PREFIX/etc/hadoop \
    JAVA_HOME=/usr/lib/jvm/java-1.8.0 \
    TERM=xterm
 
ENV PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HDFS_HOME/bin:.

RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/lib/jvm/java-1.8.0\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && \
    sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && \
    mkdir $HADOOP_PREFIX/input && \
    cp $HADOOP_PREFIX/etc/hadoop/*.xml $HADOOP_PREFIX/input

# pseudo distributed
ADD config/core-site.xml $HADOOP_PREFIX/etc/hadoop/core-site.xml
#RUN sed s/HOSTNAME/localhost/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml
ADD config/hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml

ADD config/mapred-site.xml $HADOOP_PREFIX/etc/hadoop/mapred-site.xml
ADD config/yarn-site.xml $HADOOP_PREFIX/etc/hadoop/yarn-site.xml

RUN $HADOOP_PREFIX/bin/hdfs namenode -format

ADD config/ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config && \
    chown root:root /root/.ssh/config


# workingaround docker.io build error
RUN ls -la /usr/local/hadoop/etc/hadoop/*-env.sh && \
    chmod +x /usr/local/hadoop/etc/hadoop/*-env.sh && \
    ls -la /usr/local/hadoop/etc/hadoop/*-env.sh

# fix the 254 error code
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config && \
    echo "UsePAM no" >> /etc/ssh/sshd_config && \
    echo "Port 2122" >> /etc/ssh/sshd_config


#ADD GRAPHS

RUN mkdir $HADOOP_PREFIX/google-1P
RUN mkdir $HADOOP_PREFIX/google-4P
RUN mkdir $HADOOP_PREFIX/facebook-1P
RUN mkdir $HADOOP_PREFIX/facebook-4P
RUN mkdir $HADOOP_PREFIX/ca_road_network-4P
#ADD graphs/google-input  $HADOOP_PREFIX/google-1P
ADD graphs/google-multiple  $HADOOP_PREFIX/google-4P
ADD graphs/fb-input  $HADOOP_PREFIX/facebook-1P
ADD graphs/fb-multiple  $HADOOP_PREFIX/facebook-4P 
ADD graphs/ca-road-network-4P  $HADOOP_PREFIX/ca_road_network-4P

#HAMA ENV VARIABLES

ENV HAMA_HOME /opt/hama
ENV HAMA_VERSION 0.7.1
ENV HAMA_CONF_DIR /opt/hama/conf
ENV PATH $PATH:$HAMA_HOME/bin
ENV PATH $PATH:$HADOOP_PREFIX/bin


#HAMA SETUP

RUN curl -LO  http://apache.mirror.ba/hama/hama-0.7.1/hama-dist-0.7.1.tar.gz
RUN tar -zxvf hama-dist-$HAMA_VERSION.tar.gz
RUN rm -rf hama-*.tar.gz
RUN export HAMA_HOME=$HAMA_HOME
RUN mv hama-* $HAMA_HOME
RUN rm $HAMA_HOME/conf/hama-env.sh
COPY config/hama-site.xml $HAMA_HOME/conf/
COPY config/hama-env.sh $HAMA_HOME/conf/
COPY config/hama-default.xml $HAMA_HOME/conf/
ENV PATH $PATH:$HAMA_HOME


# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 19888 8030 8031 8032 8033 8040 8042 8088 49707 2122
# Mapred ports
#EXPOSE 19888
#Yarn ports
#EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
#EXPOSE 49707 2122   

