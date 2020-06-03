# android build environment

FROM alpine:3.4
MAINTAINER JianyingLi <lijy91@foxmail.com>

# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive

# Update apt-get & Install packages
RUN apk update && \
    apk add alpine-sdk openjdk8 bash wget unzip

# Export JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV PATH $PATH:$JAVA_HOME/bin

# Install Android SDK
RUN wget -q --no-check-certificate https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && \
    unzip -q sdk-tools-linux-3859397.zip -d /usr/local/android-sdk && \
    rm sdk-tools-linux-3859397.zip && \ 
    mkdir /root/.android && touch /root/.android/repositories.cfg

# Export ANDROID_HOME variable
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/tools/bin
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/build-tools/26.0.1

RUN echo "y" | sdkmanager \
    "platforms;android-26" \
    "build-tools;26.0.1" \
    "extras;android;m2repository" \
    "extras;google;m2repository"

# Pre-install and setup all build dependencies gradle requires
COPY gradle-preinstall /root/gradle-preinstall
RUN echo "sdk.dir=$ANDROID_HOME" > /root/gradle-preinstall/local.properties && \
    chmod 0777 /root/gradle-preinstall/ && \
    /root/gradle-preinstall/gradlew build && \
    rm -rf /root/gradle-preinstall

# Creating project directories prepared for build when running
# `docker run`
ENV PROJECT /project
RUN mkdir $PROJECT
WORKDIR $PROJECT

USER $RUN_USER
RUN echo "sdk.dir=$ANDROID_HOME" > local.properties