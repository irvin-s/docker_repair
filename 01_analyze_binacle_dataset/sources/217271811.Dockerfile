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

# Download and unzip Groovy
ENV GROOVY_VERSION 2.4.14
ENV GROOVY_SDK_URL https://bintray.com/artifact/download/groovy/maven/apache-groovy-binary-${GROOVY_VERSION}.zip
RUN curl -sSL "${GROOVY_SDK_URL}" -o  apache-groovy-binary-${GROOVY_VERSION}.zip  \
	&& unzip apache-groovy-binary-${GROOVY_VERSION}.zip -d ${SDK_HOME}  \
	&& rm -rf apache-groovy-binary-${GROOVY_VERSION}.zip
ENV GROOVY_HOME ${SDK_HOME}/groovy-${GROOVY_VERSION}
ENV PATH ${GROOVY_HOME}/bin:$PATH
