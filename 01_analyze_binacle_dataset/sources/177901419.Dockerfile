# Start from a Java image.
FROM java:8

MAINTAINER xiexiaoyi <xiexiaoyijava@163.com>

# RocketMQ version
ENV ROCKETMQ_VERSION 4.2.0

# RocketMQ home
ENV ROCKETMQ_HOME /opt/rocketmq-${ROCKETMQ_VERSION}

WORKDIR  ${ROCKETMQ_HOME}

RUN mkdir -p /opt/logs /opt/store

RUN curl https://dist.apache.org/repos/dist/release/rocketmq/${ROCKETMQ_VERSION}/rocketmq-all-${ROCKETMQ_VERSION}-bin-release.zip -o rocketmq.zip
RUN unzip rocketmq.zip
RUN rm rocketmq.zip

#修改RocketMQ 内存参数
RUN cd bin && sed -i 's#-server -Xms4g -Xmx4g -Xmn2g#-server -Xms256m -Xmx256m -Xmn128m#g' runserver.sh
RUN cd bin && sed -i 's# -server -Xms8g -Xmx8g -Xmn4g# -server -Xms256m -Xmx256m -Xmn128m#g' runbroker.sh

RUN chmod +x bin/mqadmin bin/mqbroker bin/mqfiltersrv bin/mqshutdown bin/mqnamesrv

VOLUME /opt/logs /opt/store
