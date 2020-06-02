# use java8 mirror,simple to build rocket mirror
FROM java:8

# Rocket version
ENV ROCKETMQ_VERSION "${ROCKETMQ_VERSION}"

LABEL tag = base \



# config docker rocketmq arguments
ARG ROCKETMQ_LOG_PATH=/opt/rocketmq/logs
ARG ROCKETMQ_STORE_PATH=/opt/rocketmq/store

# Rocket home path
ENV ROCKETMQ_HOME  /rocketmq-${ROCKETMQ_VERSION}

#tme zone
RUN rm -rf /etc/localtime \
&& ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install rocketmq
RUN cd /opt \
    && curl http://mirror.bit.edu.cn/apache/rocketmq/${ROCKETMQ_VERSION}/rocketmq-all-#{ROCKETMQ_VERSION}-bin-release.zip -o  rocketmq-all-${ROCKETMQ_VERSION}.zip \
    && mkdir -p ${ROCKETMQ_HOME} \
    && unzip -d ${ROCKETMQ_HOME} rocketmq-all-${ROCKETMQ_VERSION}.zip \
    && rm -fr rocketmq-all-${ROCKETMQ_VERSION}.zip \
    && cd ${ROCKETMQ_HOME} \
    && mv rocketmq-all-${ROCKETMQ_VERSION}-bin-release/* ./ \
    && rm -fr rocketmq-all-${ROCKETMQ_VERSION}-bin-release

# set work home
WORKDIR  ${ROCKETMQ_HOME}

# create rocketmq data dir and log dir
RUN mkdir -p \
 $ROCKETMQ_LOG_PATH \
 $ROCKETMQ_STORE_PATH

# copy rocketmq script to rocketmq bin directory
COPY script/* ${ROCKETMQ_HOME}/bin

# link rocketmq bin file and copy config file
RUN chmod -R +x ${ROCKETMQ_HOME}/bin/* \
    && cd ${ROCKETMQ_HOME}/bin/ \
    && mkdir -p /etc/rocketmq \
    && cp -rf ${ROCKETMQ_HOME}/conf/broker.conf  /etc/rocketmq/ \
    && ln -s ${ROCKETMQ_HOME}/bin/mqadmin /usr/local/bin/mqadmin  \
    && ln -s ${ROCKETMQ_HOME}/bin/runbroker /usr/local/bin/runbroker \
    && ln -s ${ROCKETMQ_HOME}/bin/mqnamesrv /usr/local/bin/mqnamesrv \
    && ln -s ${ROCKETMQ_HOME}/bin/mqbroker /usr/local/bin/mqbroker

# set docker volume
VOLUME $ROCKETMQ_LOG_PATH $ROCKETMQ_STORE_PATH

