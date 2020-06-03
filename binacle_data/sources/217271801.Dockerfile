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

# Download and unzip Ant
ENV ANT_VERSION 1.10.1
ENV ANT_SDK_URL http://mirrors.tuna.tsinghua.edu.cn/apache//ant/binaries/apache-ant-${ANT_VERSION}-bin.zip

RUN curl -sSL "${ANT_SDK_URL}" -o apache-ant-${ANT_VERSION}-bin.zip  \
	&& unzip apache-ant-${ANT_VERSION}-bin.zip -d ${SDK_HOME}  \
	&& rm -rf apache-ant-${ANT_VERSION}-bin.zip
ENV ANT_HOME ${SDK_HOME}/apache-ant-${ANT_VERSION}
ENV PATH ${ANT_HOME}/bin:$PATH
