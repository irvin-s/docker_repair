# use java8 mirror,simple to build rocket mirror
FROM java:8

# Rocket version
ENV ROCKETMQ_VERSION "4.3.0"

MAINTAINER "Shield Team"
LABEL name="rocketmq-base"
LABEL version="2.0.1"
LABEL team="shield"
LABEL email="xiehao3692@vip.qq.com"
LABEL project-url="https://github.com/shield-project/rocketmq-spring-boot-starter"
LABEL github-url="https://github.com/"


# config docker rocketmq ENV
ENV ROCKETMQ_LOG_PATH=/opt/rocketmq/logs
ENV ROCKETMQ_STORE_PATH=/opt/rocketmq/store
ENV ROCKETMQ_CONF_PATH=/opt/rocketmq/config
ENV ROCKETMQ_HOME  /rocketmq-${ROCKETMQ_VERSION}

#tme zone
RUN rm -rf /etc/localtime \
&& ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install rocketmq
RUN cd /opt \
    && curl http://mirror.bit.edu.cn/apache/rocketmq/${ROCKETMQ_VERSION}/rocketmq-all-${ROCKETMQ_VERSION}-bin-release.zip -o  rocketmq-all-${ROCKETMQ_VERSION}.zip \
    && unzip -d ${ROCKETMQ_HOME} rocketmq-all-${ROCKETMQ_VERSION}.zip \
    && rm -fr rocketmq-all-${ROCKETMQ_VERSION}.zip \
    && cd ${ROCKETMQ_HOME} \
    && mv rocketmq-all-${ROCKETMQ_VERSION}-bin-release/* ./ \
    && rm -fr rocketmq-all-${ROCKETMQ_VERSION}-bin-release

# set work home
WORKDIR  ${ROCKETMQ_HOME}

# create rocketmq data dir and log dir
RUN mkdir -p \
    ${ROCKETMQ_LOG_PATH} \
    ${ROCKETMQ_STORE_PATH} \
    ${ROCKETMQ_CONF_PATH} \



# copy rocketmq script and default conf to rocketmq bin directory
COPY script/* ${ROCKETMQ_HOME}/bin/
COPY conf/* ${ROCKETMQ_HOME}/conf/

# link rocketmq bin file and copy config file
RUN chmod -R +x ${ROCKETMQ_HOME}/bin/* \
    && cd ${ROCKETMQ_HOME}/bin/ \
    && mkdir -p /etc/rocketmq \
    && cp -rf ${ROCKETMQ_HOME}/conf/broker.conf  /etc/rocketmq/ \
    && ln -s ${ROCKETMQ_HOME}/bin/mqadmin /usr/local/bin/mqadmin  \
    && ln -s ${ROCKETMQ_HOME}/bin/runbroker /usr/local/bin/runbroker \
    && ln -s ${ROCKETMQ_HOME}/bin/mqnamesrv /usr/local/bin/mqnamesrv \
    && ln -s ${ROCKETMQ_HOME}/bin/mqbroker /usr/local/bin/mqbroker

#copy rocketmq conf to conf dir.
RUN mkdir -p ${ROCKETMQ_CONF_PATH} \
    && cp -rf conf/* ${ROCKETMQ_CONF_PATH}/

# set docker volume
VOLUME ${ROCKETMQ_LOG_PATH} ${ROCKETMQ_STORE_PATH}