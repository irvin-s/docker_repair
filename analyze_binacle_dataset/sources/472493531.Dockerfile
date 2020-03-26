FROM openjdk:8u181-jdk-slim-stretch

LABEL maintainer="mritd <mritd@linux.com>"

ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV GRADLE_HOME /usr/local/gradle
ENV GRADLE_USER_HOME /data/gradle
ENV GRADLE_VERSION 5.1.1
ENV GRADLE_DOWNLOAD_URL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
ENV SDK_HOME /usr/local/android
ENV SDK_TOOLS_HOME /usr/local/sdktools
# SDK_TOOLS_VERSION refs: https://developer.android.com/studio/#command-tools
ENV SDK_TOOLS_VERSION 4333796
ENV SDK_TOOLS_DOWNLOAD_URL https://dl.google.com/android/repository/sdk-tools-linux-${SDK_TOOLS_VERSION}.zip

RUN apt update -y \
    && apt upgrade -y \
    && apt install tzdata wget openssl unzip libstdc++ -y \
    && wget ${GRADLE_DOWNLOAD_URL} \
    && unzip gradle-${GRADLE_VERSION}-bin.zip \
    && mv gradle-${GRADLE_VERSION} ${GRADLE_HOME} \
    && ln -s ${GRADLE_HOME}/bin/gradle /usr/local/bin/gradle \
    && wget ${SDK_TOOLS_DOWNLOAD_URL} \
    && unzip sdk-tools-linux-${SDK_TOOLS_VERSION}.zip \
    && mkdir ${SDK_HOME} \
    && mv tools ${SDK_TOOLS_HOME} \
    && ln -s ${SDK_TOOLS_HOME}/bin/* /usr/local/bin \
    && yes | sdkmanager --licenses --sdk_root=${SDK_HOME} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apt autoremove -y \
    && apt autoclean -y \
    && rm -rf   /var/lib/apt/lists/* \
                gradle-${GRADLE_VERSION}-bin.zip \
                sdk-tools-linux-${SDK_TOOLS_VERSION}.zip

CMD ["/bin/bash"]
