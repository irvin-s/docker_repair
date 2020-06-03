# common-slave but with java12
FROM adoptopenjdk/openjdk12:x86_64-ubuntu-jdk-12.33
MAINTAINER Sławek Piotrowski <sentinel@atteo.com>

ENV HOME /home/jenkins
ENV LANG en_US.UTF-8
ENV _JAVA_OPTIONS -Dfile.encoding=UTF-8

RUN useradd -c "Jenkins user" -d $HOME -m jenkins

WORKDIR /home/jenkins

COPY ssh_config .ssh/config
RUN chown jenkins.jenkins .ssh/config

USER jenkins


# versions
ENV MAVEN_VERSION 3.6.0
ENV MAVEN_HOME /usr/share/maven

USER root

RUN apt-get update && apt-get -y install \
	git \
	&& rm -rf /var/lib/apt/lists/*

# Maven
RUN mkdir -p $MAVEN_HOME \
  && curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC $MAVEN_HOME --strip-components=1 \
  && ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn

RUN mkdir -p .m2/repository && chown -R jenkins.jenkins .m2

ENV MVN_COMPILE_GOALS="clean install" \
    PATH=$PATH:/home/jenkins/bin

COPY mvn-incremental /home/jenkins/bin/
RUN  chmod -R +x /home/jenkins/bin \
     && chown -R jenkins.jenkins /home/jenkins/bin

USER jenkins
