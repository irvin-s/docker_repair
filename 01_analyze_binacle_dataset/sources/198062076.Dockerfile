FROM jfactory/common-slave:latest
MAINTAINER Sławek Piotrowski <sentinel@atteo.com>

# versions
ENV MAVEN_VERSION 3.6.0
ENV MAVEN_HOME /usr/share/maven

USER root

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
