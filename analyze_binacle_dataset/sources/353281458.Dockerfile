FROM blacklabelops/jenkins-swarm
MAINTAINER Steffen Bleul <sbl@blacklabelops.com>

# Need root to build image
USER root

# install dev tools
RUN yum install -y \
    unzip && \
    yum clean all && rm -rf /var/cache/yum/*

# this envs are for maintaining java updates.
ENV JAVA_MAJOR_VERSION=6
ENV JAVA_UPDATE_VERSION=45
ENV JAVA_BUILD_NUMER=06
# install java
ENV JAVA_VERSION=1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}
ENV JAVA_TARBALL=jdk-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.bin
ENV JAVA_HOME=/opt/java/jdk${JAVA_VERSION}

RUN wget --directory-prefix=/tmp \
         --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
         http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMER}/${JAVA_TARBALL} && \
    mkdir -p /opt/java && \
    chmod +x /tmp/${JAVA_TARBALL} && \
    /tmp/${JAVA_TARBALL} && \
    mv jdk${JAVA_VERSION} /opt/java && \
    alternatives --remove java ${SWARM_JAVA_HOME}/bin/java && \
    alternatives --install /usr/bin/java java /opt/java/jdk${JAVA_VERSION}/bin/java 100 && \
    rm -rf /tmp/* && rm -rf /var/log/*

# install maven
ENV MAVEN_VERSION=3.2.5
ENV M2_HOME=/usr/local/maven
RUN wget --directory-prefix=/tmp \
    http://mirror.synyx.de/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar xzf /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /usr/local && rm -rf /tmp/* && \
    cd /usr/local &&  ln -s apache-maven-${MAVEN_VERSION} maven && \
    alternatives --install /usr/bin/mvn mvn /usr/local/maven/bin/mvn 100

# install gradle
ENV GRADLE_VERSION=2.14.1
ENV GRADLE_HOME=/usr/local/gradle
RUN wget --directory-prefix=/tmp \
    https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip /tmp/gradle-${GRADLE_VERSION}-bin.zip -d /usr/local && rm -rf /tmp/* && \
    cd /usr/local &&  ln -s gradle-${GRADLE_VERSION} gradle && \
    alternatives --install /usr/bin/gradle gradle /usr/local/gradle/bin/gradle 100

# Switch back to user jenkins
USER $CONTAINER_UID
