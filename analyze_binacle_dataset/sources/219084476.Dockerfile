FROM node:8

RUN apt-get update \
  && apt-get -y install apt-utils \
          build-essential \
          git-core \
          curl libssl-dev \
          libreadline-dev \
          zlib1g zlib1g-dev \
          libcurl4-openssl-dev \
          libxslt-dev libxml2-dev \
          locales \
          apt-transport-https \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*

# install java, for Selenium and for Android
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list.d/backports.list \
  && apt-get update \
  && apt-get install -t jessie-backports -y openjdk-8-jdk-headless \
  && rm /etc/apt/sources.list.d/backports.list \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*

# install chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update \
  && apt-get -y install google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*
ENV CHROME_BIN /usr/bin/google-chrome-stable

RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS /dev/null

# Install Android SDK

ENV ANDROID_SDK_VERSION 3859397
ENV ANDROID_HOME /usr/local/bin/android-sdk

RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y lib32z1 libc6:i386 libncurses5:i386 libstdc++6:i386 expect zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
    && unzip sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
    && mv tools ${ANDROID_HOME} \
    && rm sdk-tools-linux-${ANDROID_SDK_VERSION}.zip

ENV PATH $PATH:${ANDROID_HOME}/bin:${ANDROID_HOME}/platform-tools

RUN mkdir ~/.android && touch ~/.android/repositories.cfg
RUN echo y | sdkmanager --verbose "platform-tools" "platforms;android-25" "build-tools;26.0.0"
RUN echo y | sdkmanager --verbose "extras;android;m2repository"

# Gradle
ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 4.0.1
ENV GRADLE_DOWNLOAD_SHA256 d717e46200d1359893f891dab047fdab98784143ac76861b53c50dbd03b44fd4

RUN set -o errexit -o nounset \
    && echo "Downloading Gradle" \
    && wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
    \
    && echo "Checking download hash" \
    && echo "${GRADLE_DOWNLOAD_SHA256} *gradle.zip" | sha256sum --check - \
    \
    && echo "Installing Gradle" \
    && unzip gradle.zip \
    && rm gradle.zip \
    && mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
    && ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle
