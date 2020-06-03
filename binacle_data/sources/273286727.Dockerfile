FROM ubuntu:bionic-20181018

ARG root=.
ARG jar=target/artifactory-resource.jar

COPY ${root}/assets/ /opt/resource/
COPY ${jar} /artifact/artifactory-resource.jar


RUN apt-get update
RUN apt-get install --no-install-recommends -y ca-certificates curl
RUN rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /opt/openjdk
ENV PATH $JAVA_HOME/bin:$PATH
RUN mkdir -p /opt/openjdk && \
    cd /opt/openjdk && \
    curl https://java-buildpack.cloudfoundry.org/openjdk/bionic/x86_64/openjdk-1.8.0_192.tar.gz | tar xz

RUN chmod +x /opt/resource/check /opt/resource/in /opt/resource/out
