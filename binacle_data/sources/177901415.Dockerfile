ARG BASE_IMAGE

# Start from a base image.
FROM $BASE_IMAGE

MAINTAINER xiexiaoyi <xiexiaoyijava@163.com>

# RocketMQ version
ENV ROCKETMQ_VERSION 4.0.0-incubating
# RocketMQ home
ENV ROCKETMQ_HOME  /opt/rocketmq-${ROCKETMQ_VERSION}

WORKDIR  ${ROCKETMQ_HOME}

RUN mkdir -p /opt/logs /opt/store

ARG BROKER_IP1
ARG LISTEN_PORT
ARG PROPERTIES_FILE

ENV PROPERTIES_FILE $PROPERTIES_FILE

RUN echo "brokerIP1=$BROKER_IP1" >> $ROCKETMQ_HOME/conf/$PROPERTIES_FILE \
    && echo "listenPort=$LISTEN_PORT" >> $ROCKETMQ_HOME/conf/$PROPERTIES_FILE \
    && echo "autoCreateTopicEnable=true" >> $ROCKETMQ_HOME/conf/$PROPERTIES_FILE \
    && echo "autoCreateSubscriptionGroup=true" >> $ROCKETMQ_HOME/conf/$PROPERTIES_FILE

VOLUME /opt/logs /opt/store

ENV JAVA_OPT=" -Duser.home=/opt"

WORKDIR ${ROCKETMQ_HOME}/bin

CMD sh mqbroker -c $ROCKETMQ_HOME/conf/$PROPERTIES_FILE
