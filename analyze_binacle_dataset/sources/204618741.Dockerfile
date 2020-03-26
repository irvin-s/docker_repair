FROM centos:7.3.1611

ADD data /chronos-build

ENV MAVEN_VERSION 3.3.9
ENV M2_HOME /usr/apache-maven-3.3.9

RUN yum update -y \
    && yum swap -y fakesystemd systemd \
    && yum groupinstall "Development Tools" -y \
    && curl --silent --location https://rpm.nodesource.com/setup | bash - \
    && yum install -y wget curl git java-1.8.0-openjdk-devel ruby-devel nodejs \
    && gem install fpm --no-ri --no-rdoc \
    && mkdir -p /tmp/apache-maven-$MAVEN_VERSION \
    && cd /tmp/apache-maven-$MAVEN_VERSION \
    && wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    && gunzip apache-maven-$MAVEN_VERSION-bin.tar.gz \
    && tar -xf apache-maven-$MAVEN_VERSION-bin.tar -C /usr/ \
    && ln -s $M2_HOME/bin/mvn /usr/local/bin/mvn \
    && chmod +x /chronos-build/chronos-build.sh

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk
ENV BUILD_CHRONOS_PACKAGE_NAME chronos
ENV BUILD_CHRONOS_VERSION master
ENV FPM_OUTPUT_VERSION 0.0.1
ENV INSTALL_DIRECTORY /opt/chronos
