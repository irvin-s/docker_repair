FROM ubuntu:14.04

MAINTAINER Khozzy <khozzy@gmail.com>

ENV FIREFOX_VERSION 41.0.2+build2-0ubuntu0.14.04.1
ENV MAVEN_VERSION 3.3.3
ENV MAVEN_HOME /usr/share/maven
ENV PATH $MAVEN_HOME/bin:$PATH
ENV UID 1000
ENV GID 1000

#================================================
# Add dedicated user
#================================================
RUN groupadd -r firefox -g $GID && useradd -u $UID -r -m -g firefox firefox

#================================================
# Customize sources for apt-get
#================================================
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/OracleJava.list \
    && echo "deb http://archive.canonical.com/ubuntu trusty partner" > /etc/apt/sources.list.d/CanonicalPartners.list

#================================================
# Install Firefox, Java 8, Flash, Xvfb
#================================================
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
    && apt-get update \
    && apt-get install -y  firefox=$FIREFOX_VERSION \
                        dbus-x11 \
                        adobe-flashplugin \
                        libxext-dev \
                        libxrender-dev \
                        libxtst-dev \
                        oracle-java8-installer \
                        oracle-java8-set-default \
			xvfb \
			curl \
    && rm -rf /var/lib/apt/lists/*

#============================
# Install Maven
#============================
RUN curl -SL "http://ftp.ps.pl/pub/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" -o maven.tar.gz \
    && curl -SL "http://www.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz.asc" -o maven.tar.gz.asc \
    && gpg --keyserver pgpkeys.mit.edu --recv-key BB617866 \
    && gpg --verify maven.tar.gz.asc maven.tar.gz \
    && mkdir -p $MAVEN_HOME \
    && tar -xf maven.tar.gz -C $MAVEN_HOME --strip-components=1 \
    && rm -rf maven.tar.gz*

#=======================
# Xvfb + init scripts
#=======================
ADD libs/xvfb_init /etc/init.d/xvfb
RUN chmod a+x /etc/init.d/xvfb

ADD libs/xvfb-daemon-run /usr/bin/xvfb-daemon-run
RUN chmod a+x /usr/bin/xvfb-daemon-run

USER firefox
