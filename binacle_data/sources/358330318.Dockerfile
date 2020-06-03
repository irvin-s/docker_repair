FROM oracle-jdk7
MAINTAINER kuizhi.feng

################### prepare      ##################
ADD . /project

################### install zooKeeper ##################
RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /usr/local/

ENV PATH $PATH:/usr/local/zookeeper-3.4.6/bin
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

RUN cp /project/conf/zookeeper/zoo.cfg /usr/local/zookeeper-3.4.6/conf/zoo.cfg


CMD /project/conf/zookeeper/docker-entrypoint.sh

EXPOSE 2181 2182 2183