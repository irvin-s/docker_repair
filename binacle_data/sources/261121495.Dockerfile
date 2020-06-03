FROM jetbrains/teamcity-agent:2018.1.4

MAINTAINER Paweł Gajda

ENV GRADLE_HOME=/usr/bin/gradle

RUN apt-get update
RUN apt-get install -y --force-yes expect git mc gradle unzip \
    wget curl libc6-i386 lib32stdc++6 lib32gcc1 \
    lib32ncurses5 lib32z1
RUN apt-get clean
RUN rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD android-accept-licenses.sh /opt/tools/
ENV PATH ${PATH}:/opt/tools
ENV LICENSE_SCRIPT_PATH /opt/tools/android-accept-licenses.sh

RUN cd /opt && wget --output-document=android-tools.zip \
    https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip android-tools.zip -d android-sdk-linux && \
    chown -R root.root android-sdk-linux

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN yes | sdkmanager --licenses
RUN sdkmanager "ndk-bundle"
