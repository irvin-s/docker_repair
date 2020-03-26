FROM openjdk:8

MAINTAINER snowdream <yanghui1986527@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get -qq update && \
    apt-get -qqy install --no-install-recommends \
       unzip \
     && rm -rf /var/lib/apt/lists/*

# Everything will be installed in the directory but jdk.
ENV SDK_HOME /usr/local

# Download and unzip Gradle
ENV GRADLE_VERSION 5.0
ENV GRADLE_SDK_URL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
RUN curl -sSL "${GRADLE_SDK_URL}" -o gradle-${GRADLE_VERSION}-bin.zip  \
	&& unzip gradle-${GRADLE_VERSION}-bin.zip -d ${SDK_HOME}  \
	&& rm -rf gradle-${GRADLE_VERSION}-bin.zip
ENV GRADLE_HOME ${SDK_HOME}/gradle-${GRADLE_VERSION}
ENV PATH ${GRADLE_HOME}/bin:$PATH
