FROM demoregistry.dataman-inc.com/library/centos7-jdk8:latest
MAINTAINER jyliu <jyliu@dataman-inc.com>

# install zookeeper
RUN curl -o - http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz|tar -zxf - -C /opt \
    && ln -s  /opt/zookeeper-3.4.6 /usr/local/zookeeper

# create URI dir
RUN mkdir -p /data/run && \
    mkdir -p /data/logs && \
# create zookeeper dir
    mkdir -p /data/zookeeper/zklog && \
    mkdir -p /data/zookeeper/snapshot

# copy zoo.cfg
COPY zoo.cfg.template /usr/local/zookeeper/conf/zoo.cfg
#env
COPY zkServer.sh /usr/local/zookeeper/bin/

# run script
COPY dataman_zookeeper.sh /data/run/

RUN chmod 755 /data/run/dataman_zookeeper.sh

WORKDIR /usr/local/zookeeper
EXPOSE 2181 2888 3888
ENTRYPOINT ["/data/run/dataman_zookeeper.sh"]
