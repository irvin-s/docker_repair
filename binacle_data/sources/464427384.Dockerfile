FROM ubuntu:trusty

MAINTAINER Docker Hub

CMD ["sh", "adduser jenkins sudo"] 

# Set some variables	
ARG MAVEN_VERSION=3.3.9
ARG USER_HOME_DIR="/root"
ARG JAVA_VERSION=8

# Add locales after locale-gen as needed
# Upgrade packages on image
# Preparations for sshd
run locale-gen en_US.UTF-8 &&\
    apt-get -q update &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" --no-install-recommends &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew"  --no-install-recommends openssh-server &&\
    apt-get -q autoremove &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin &&\
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd &&\
    mkdir -p /var/run/sshd

# Sets language to UTF8 : this works in pretty much all cases	
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install JDK
# Install the python script required for "add-apt-repository"
RUN apt-get update && apt-get install -y software-properties-common

# Setup the OpenJDK repo
RUN add-apt-repository ppa:openjdk-r/ppa

# Installing ...
RUN apt-get update && apt-get install -y openjdk-$JAVA_VERSION-jdk

# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-$JAVA_VERSION-openjdk-amd64/
RUN export JAVA_HOME

# Set user jenkins to the image
RUN useradd -m -d /home/jenkins -s /bin/sh jenkins &&\
    echo "jenkins:jenkins" | chpasswd
RUN adduser jenkins sudo

# Install curl
RUN apt-get update && apt-get install -y curl git && apt-get clean && rm -rf /var/lib/apt/lists

# Install Maven
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

VOLUME "$USER_HOME_DIR/.m2"

# SSH port
EXPOSE 22

CMD ["mvn -version"]