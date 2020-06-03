FROM shield-project/rocketmq-base:2.0.1

MAINTAINER "Shield Team"
LABEL name="rocketmq-namesrv"
LABEL version="2.0.1"
LABEL team="shield"
LABEL email="xiehao3692@vip.qq.com"
LABEL project-url="https://github.com/shield-project/rocketmq-spring-boot-starter"
LABEL github-url="https://github.com/"

ARG PORT=9876

EXPOSE $PORT
#RUN mv ${ROCKETMQ_HOME}/bin/runserver-customize.sh ${ROCKETMQ_HOME}/bin/runserver.sh \
# && chmod +x ${ROCKETMQ_HOME}/bin/runserver.sh \
# && chmod +x ${ROCKETMQ_HOME}/bin/mqnamesrv

CMD mqnamesrv