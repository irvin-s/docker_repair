FROM ubuntu:15.04
MAINTAINER Selion <selion@googlegroups.com>

# Builds on docker selenium (https://github.com/SeleniumHQ/docker-selenium) which we customize for SeLion.
# This is copy of selenium base.  Inheriting FROM selenium base didn't allow over-riding some
# choices already made in selenium base.

# This Docker is just a base for the other SeLion docker images.

# TODOs:
# Selenium using openjdk (openjdk-8-jre-headless)
# Consider this base instead https://github.com/phusion/baseimage-docker

#==============================
# Customize sources for apt-get
#==============================
RUN  echo "deb http://archive.ubuntu.com/ubuntu vivid main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu vivid-updates main universe\n" >> /etc/apt/sources.list

#==============================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#==============================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    ca-certificates \
    openjdk-8-jre-headless \
    sudo \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

# The Selenium server version (Keep in sync with Selion server)
ENV SELENIUM_VERSION=%SELENIUM_VERSION%
ENV SELENIUM_FIX=%SELENIUM_FIX%

# Selenium base was already using /opt
ENV SELION_HOME /opt/selion

ENV SEL_SERVER https://selenium-release.storage.googleapis.com
ENV REDIRECT_URL https://oss.sonatype.org/service/local/artifact/maven/content
ENV REPO=%REPO%
ENV SELION_GRID_VERSION=%SELION_GRID_VERSION%

#=============================
# Add selion + selenium server
#=============================
RUN  mkdir -p ${SELION_HOME} \
  && wget --no-verbose "$REDIRECT_URL?r=$REPO&g=com.paypal.selion&a=SeLion-Grid&c=jar-with-dependencies&v=$SELION_GRID_VERSION" -O $SELION_HOME/SeLion-Grid.jar \
  && wget --no-verbose $SEL_SERVER/$SELENIUM_VERSION/selenium-server-standalone-$SELENIUM_VERSION.$SELENIUM_FIX.jar -O $SELION_HOME/selenium-server-standalone.jar

#========================================
# Add normal user with passwordless sudo
#========================================
RUN sudo useradd seluser --shell /bin/bash --create-home \
  && sudo usermod -a -G sudo seluser \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'seluser:secret' | chpasswd

#=====================================================================
# Add an empty SeLion download.json. The dependencies will be in place
#=====================================================================
# Empty file to suppress downloads
COPY download.json $SELION_HOME/config/download.json
