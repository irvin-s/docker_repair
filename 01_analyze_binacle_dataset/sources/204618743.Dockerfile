FROM centos:7.3.1611

ADD data /marathon-build

RUN yum update -y \
    && yum swap -y fakesystemd systemd \
    && yum groupinstall "Development Tools" -y \
    && yum install -y curl git java-1.8.0-openjdk-devel ruby-devel \
    && curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo \
    && yum install -y sbt \
    && gem install fpm --no-ri --no-rdoc \
    && chmod +x /marathon-build/marathon-build.sh

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk
ENV BUILD_MARATHON_PACKAGE_NAME marathon
ENV BUILD_MARATHON_VERSION master
ENV FPM_OUTPUT_VERSION 0.0.1
ENV INSTALL_DIRECTORY /opt/marathon
