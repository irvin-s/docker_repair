FROM ubuntu:16.04

MAINTAINER Sergio Morales "sdmoralesma@gmail.com"

#Install packages on ubuntu base image
RUN \
  apt-get update && \
  apt-get install -y && \
  apt-get install -y software-properties-common && \
  apt-get install -y wget unzip

# Install JDK 8
RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Install WildFly to /opt
ENV WILDFLY_VERSION 10.1.0.Final
RUN cd /opt && wget http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz && \
  tar xvf wildfly-$WILDFLY_VERSION.tar.gz && \
  ln -s /opt/wildfly-$WILDFLY_VERSION /opt/wildfly && \
  rm wildfly-$WILDFLY_VERSION.tar.gz

ENV JBOSS_HOME /opt/wildfly

# Create admin user for wildfly
RUN $JBOSS_HOME/bin/add-user.sh admin admin123 --silent

# dowload mysql connector
RUN mkdir $JBOSS_HOME/connector/ && \
  cd $JBOSS_HOME/connector/ && \
  wget http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.38/mysql-connector-java-5.1.38.jar

#add datasource to wildfly
ADD wildfly-config/scripts $JBOSS_HOME/scripts/
RUN $JBOSS_HOME/scripts/execute.sh

# Solves bug in history
RUN rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/current

# Install Gradle
ENV GRADLE_VERSION 3.0
WORKDIR /usr/bin
RUN wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip && \
  unzip gradle-$GRADLE_VERSION-bin.zip && \
  ln -s gradle-$GRADLE_VERSION gradle && \
  rm gradle-$GRADLE_VERSION-bin.zip

# Set Appropriate Environmental Variables
ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# Install Ruby Buildr
RUN \
  apt-get install -y  build-essential ruby ruby-dev ruby-bundler && \
  rm -rf /var/lib/apt/lists/*
RUN gem install buildr

ENV BUILDR_HOME /usr/local/bin/buildr
ENV PATH $PATH:$BUILDR_HOME

# Create the wildfly user and group
RUN groupadd -r wildfly-group -g 433 && \
  useradd -u 431 -r -g wildfly-group -s /bin/false wildfly -m

# Gradle workaround, will explode if TERM isn't declared
ENV TERM xterm

ENV USER_HOME /home/wildfly

# Add java project
ADD java-gradle $USER_HOME/java-gradle

# Add scala project
ADD scala-gradle $USER_HOME/scala-gradle

# Add groovy project
ADD groovy-gradle $USER_HOME/groovy-gradle

# Run everything below as the wildfly user
RUN chown -R wildfly:wildfly-group $JBOSS_HOME/* && \
  chown -R wildfly:wildfly-group $USER_HOME/* && \
  chmod -R 777 $JBOSS_HOME/* && \
  chmod -R 777 $USER_HOME/*

USER wildfly

# Expose the ports
EXPOSE 8080 9990 8787 8443

# Boot WildFly in the standalone mode and bind to all interfaces
CMD ["sh", "-c", "${JBOSS_HOME}/bin/standalone.sh", "--debug", "8787", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
