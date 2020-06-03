FROM ubuntu:14.04

MAINTAINER kiwenlau <kiwenlau@gmail.com>

# 设置时区
RUN sudo echo "Asia/Tokyo" > /etc/timezone && \
    sudo dpkg-reconfigure -f noninteractive tzdata

WORKDIR /root

# jre
RUN  sudo apt-get update -y && sudo apt-get install -y openjdk-7-jre wget

# 安装ZooKeeper 3.4.8
RUN wget http://ftp.jaist.ac.jp/pub/apache/zookeeper/zookeeper-3.4.8/zookeeper-3.4.8.tar.gz && \
    tar -C /usr/local/bin -xzvf zookeeper-3.4.8.tar.gz && \
    rm zookeeper-3.4.8.tar.gz && \
    mv /usr/local/bin/zookeeper-3.4.8/conf/zoo_sample.cfg /usr/local/bin/zookeeper-3.4.8/conf/zoo.cfg 

ENV PATH=$PATH:/usr/local/bin/zookeeper-3.4.8/bin

CMD ["zkServer.sh", "start-foreground"]
