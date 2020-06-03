FROM ubuntu:xenial

RUN apt-get update \
  && apt-get install -y --no-install-recommends curl tar gzip default-jre vim

# Install Spire Agent
ARG SPIRE_VERSION=0.6.0
ARG SPIRE_RELEASE=https://github.com/spiffe/spire/releases/download/${SPIRE_VERSION}/spire-${SPIRE_VERSION}-linux-x86_64-glibc.tar.gz
ARG SPIRE_DIR=/opt/spire

RUN curl --silent --location $SPIRE_RELEASE | tar -xzf -
RUN mv spire-${SPIRE_VERSION} ${SPIRE_DIR}

# Install Tomcat
ARG TOMCAT_VERSION=8.5.34
ARG TOMCAT_RELEASE="http://apache.dattatec.com/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
ARG TOMCAT_DIR=/opt/tomcat
RUN curl --silent --location ${TOMCAT_RELEASE} | tar -xzf -
RUN mv apache-tomcat-${TOMCAT_VERSION} ${TOMCAT_DIR}

# Install Spiffe Security Provider
COPY spiffe-provider-0.1.0.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/ext/

# Configure Spire
WORKDIR ${SPIRE_DIR}
COPY agent.conf conf/agent/agent.conf

