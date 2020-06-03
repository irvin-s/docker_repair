FROM ubuntu:16.10
MAINTAINER Irfan <irfan@critick.io>

#=============================================
# Install Android SDK's and Platform tools
#=============================================
RUN export DEBIAN_FRONTEND=noninteractive \
  && dpkg --add-architecture i386 \
  && apt-get update -y \
  && apt-get -y --no-install-recommends install \
    libc6-i386 \
    lib32stdc++6 \
    lib32gcc1 \
    gcc-5-base \
    lib32ncurses5 \
    lib32z1 \
    wget \
    curl \
    unzip \
    openjdk-8-jdk \
  && wget --progress=dot:giga -O /opt/adt.tgz \
    https://dl.google.com/android/android-sdk_r24.3.4-linux.tgz \
  && tar xzf /opt/adt.tgz -C /opt \
  && rm /opt/adt.tgz \
  && echo y | /opt/android-sdk-linux/tools/android update sdk --all --filter platform-tools,build-tools-23.0.3 --no-ui --force \
  && apt-get -qqy clean \
  && rm -rf /var/cache/apt/*

#================================
# Set up PATH for Android Tools
#================================
ENV PATH $PATH:/opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools
ENV ANDROID_HOME /opt/android-sdk-linux

#==========================
# Install Appium Dependencies
#==========================
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
  && apt-get -qqy install \
    nodejs \
    python \
    make \
    build-essential \
    g++

#=====================
# Install Appium
#=====================
ENV APPIUM_VERSION 1.5.3

RUN mkdir /opt/appium \
  && cd /opt/appium \
  && npm install appium@$APPIUM_VERSION \
  && ln -s /opt/appium/node_modules/.bin/appium /usr/bin/appium

EXPOSE 4723

#==========================
# Run appium as default
#==========================
CMD /usr/bin/appium
