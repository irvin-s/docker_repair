FROM ubuntu:14.04

MAINTAINER Qin Han "qinhan@xingshulin.com"

COPY ./scripts/install-oracle-java8.sh ./install-oracle-java8.sh
RUN ./install-oracle-java8.sh

ENV ANDROID_HOME /opt/android-sdk-linux

COPY ./scripts/install-android-sdk.sh ./install-android-sdk.sh
RUN ./install-android-sdk.sh ${ANDROID_HOME}

# Setup environment
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN which adb
RUN which android

ENV JENKINS_URL http://localhost:8080
ENV JENKINS_USER admin
ENV JENKINS_PASSWORD admin
ENV NODE_NAME ''
ENV NODE_LABEL android

COPY ./scripts/start-slave.sh ./start-slave.sh

RUN mkdir -p /var/jenkins_slave/

HEALTHCHECK CMD curl -s "$JENKINS_URL/computer/$HOSTNAME/api/json" | grep \"offline\":false

ENTRYPOINT ["./start-slave.sh"]

