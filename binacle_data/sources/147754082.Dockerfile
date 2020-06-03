FROM jenkins/jenkins:2.150.1

# Install plugins
RUN /usr/local/bin/install-plugins.sh maven-plugin git workflow-aggregator gatling blueocean pipeline-stage-view

# Maven Integration Plugin
# Git plugin
# Pipeline
# Gatling Jenkins Plugin
# Blue Ocean
# Pipeline: Stage View Plugin


# Disable plugin dialog
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state


# Run as root. Not so good from a security perspective, but easier to config for tool installation and access to docker socket
USER root 

# Install Java 11
RUN wget https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz -O /tmp/openjdk-11_linux-x64_bin.tar.gz \
  && tar xfvz /tmp/openjdk-11_linux-x64_bin.tar.gz --directory /usr/lib/jvm \
  && rm -f /tmp/openjdk-11_linux-x64_bin.tar.gz

# Install Maven
ARG MAVEN_VERSION=3.6.0
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-$MAVEN_VERSION-bin.tar.gz \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

ADD settings.xml /usr/share/maven/conf/settings.xml

# Using the docker client from the docker host (with -v /usr/bin/docker:/usr/bin/docker) no longer works, as the docker client is no longer a static binary in the default installation. Instead, install the static docker client library from github.
# Install statc docker client library. NOTE: Hardcoded docker client version.
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-18.09.0.tgz  &&\
    tar -xvzf ./docker-*.tgz &&\
    mv ./docker/docker /usr/bin/docker &&\
    chmod +x /usr/bin/docker &&\
    rm -rf ./docker