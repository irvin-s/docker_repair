FROM ubuntu:14.04

ENV DEBIAN_FRONTEND=noninteractive

ARG http_proxy
ARG https_proxy
ARG no_proxy
ENV http_proxy=$http_proxy https_proxy=$https_proxy no_proxy=$no_proxy

# Install OpenJDK (Evading license violation of O* Java)
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install --no-install-recommends -y openjdk-8-jdk && \
    rm -rf /var/cache/openjdk-8-jdk && \
    echo "networkaddress.cache.ttl=60" >> /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
