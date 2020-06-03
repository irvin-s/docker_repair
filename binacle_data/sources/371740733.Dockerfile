FROM ubuntu:14.04

MAINTAINER Qin Han "qinhan@xingshulin.com"

COPY ./scripts/install-oracle-java8.sh ./install-oracle-java8.sh
RUN ./install-oracle-java8.sh

ENV ANDROID_HOME /opt/android-sdk-linux

COPY ./scripts/install-android-sdk.sh ./install-android-sdk.sh
RUN ./install-android-sdk.sh $ANDROID_HOME

# Setup environment
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN which adb
RUN which android

# GO to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
