FROM debian:jessie
MAINTAINER info@praqma.net

# Update and install basic tools inc. Oracle JDK 1.8
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
	echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
	apt-get update && \
	echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
	echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
	apt-get install libapr1 libaprutil1 libtcnative-1 oracle-java8-installer oracle-java8-set-default curl vim wget unzip nmap libtcnative-1 xmlstarlet --force-yes -y && \
        apt-get clean

# Define JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Add /srv/java on PATH variable
ENV PATH ${PATH}:${JAVA_HOME}/bin:/srv/java
