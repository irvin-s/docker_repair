FROM openjdk:8u151-jdk-alpine3.7

RUN \
       mkdir /tmp/rocketmq \
    && mkdir -p /data0/soft/rocketmq \
    && cd /tmp/rocketmq \
    && wget -q -P /tmp/rocketmq http://mirrors.shu.edu.cn/apache/rocketmq/4.2.0/rocketmq-all-4.2.0-bin-release.zip \
    && unzip -d /data0/soft/rocketmq /tmp/rocketmq/rocketmq*.zip \
    && rm -fr /tmp/rocketmq/

COPY ./start.sh /data0/soft/rocketmq/
COPY ./runbroker.sh /data0/soft/rocketmq/bin/
WORKDIR /data0/soft/rocketmq

EXPOSE 9876 10911

CMD /data0/soft/rocketmq/start.sh