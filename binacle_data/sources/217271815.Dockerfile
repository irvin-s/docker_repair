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

# Download and unzip Maven
ENV MAVEN_VERSION 3.5.2
ENV MAVEN_SDK_URL http://mirror.bit.edu.cn/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.zip

RUN curl -sSL "${MAVEN_SDK_URL}" -o apache-maven-${MAVEN_VERSION}-bin.zip  \
	&& unzip apache-maven-${MAVEN_VERSION}-bin.zip -d ${SDK_HOME}  \
	&& rm -rf apache-maven-${MAVEN_VERSION}-bin.zip
ENV MAVEN_HOME ${SDK_HOME}/apache-maven-${MAVEN_VERSION}
ENV PATH ${MAVEN_HOME}/bin:$PATH
