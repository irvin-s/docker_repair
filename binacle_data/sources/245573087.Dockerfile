# Android ubuntu build environment for Red Panda jpl
# version 0.1.0

FROM ubuntu:17.10

ENV DEBIAN_FRONTEND noninteractive

# Add android tools and platform tools to PATH
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
RUN echo ANDROID_HOME="${ANDROID_HOME}" >> /etc/environment

# Update packages
RUN apt-get -y update && \
    dpkg --add-architecture i386 && \
    apt-get -y install openjdk-8-jdk && \
    apt-get -y install git wget curl unzip make g++ ruby ruby-dev locales libqt5widgets5 unzip && \
    apt-get install -y expect ant libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install android sdk
RUN wget -qO- http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz | \
    tar xvz -C /usr/local/ && \
    mv /usr/local/android-sdk-linux /usr/local/android-sdk && \
    chown -R root:root /usr/local/android-sdk/

# Install latest android tools and system images
RUN ( sleep 4 && while [ 1 ]; do sleep 1; echo y; done ) | android update sdk --no-ui --force -a --filter \
    platform-tool,tools,extra-android-m2repository,extra-google-m2repository

RUN [ -e ${ANDROID_HOME}/temp/*.zip ] && unzip ${ANDROID_HOME}/temp/*.zip -d ${ANDROID_HOME} && rm ${ANDROID_HOME}/temp/*.zip || echo "No unzip"

# Locale settings
RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# FASTLANE STUFF
RUN gem install fastlane -NV

RUN mkdir /.gem /.crashlytics && \
    chmod 777 -R /.gem /.crashlytics /var/lib/gems/2.3.0 /home

# Work directory
WORKDIR /home
