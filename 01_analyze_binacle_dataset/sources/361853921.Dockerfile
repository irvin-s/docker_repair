############################################################
# Dockerfile to deploy BIMserver 1.4.0 on Tomcat 8.0.30
# Based on Ubuntu 14.04 x64
############################################################

FROM ubuntu:14.04
MAINTAINER connor@jenca.io

# Initialise software and update the repository sources list

RUN apt-get update
RUN apt-get -y install software-properties-common && \
	add-apt-repository -y ppa:openjdk-r/ppa
RUN apt-get -y update && apt-get -y install \
	openjdk-8-jdk \
	git \
	ant \
	wget
RUN echo "Europe/London" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

################## BEGIN INSTALLATION ######################

# Create Tomcat root directory, set up users and install Tomcat

RUN mkdir /opt/tomcat
RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
RUN wget http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.3/bin/apache-tomcat-8.0.3.tar.gz \
	-O /tmp/apache-tomcat-8.0.30.tar.gz
RUN tar xvf /tmp/apache-tomcat-8.0.30.tar.gz -C /opt/tomcat --strip-components=1
RUN rm -f /tmp/apache-tomcat-8.0.30.tar.gz

# Set permissions for group and user to install BIMserver and edit conf

RUN chgrp -R tomcat /opt/tomcat/conf
RUN chmod g+rwx /opt/tomcat/conf
RUN chmod g+r /opt/tomcat/conf/*
RUN chown -R tomcat /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/
RUN chown -R tomcat /opt && chown -R tomcat /opt/tomcat/webapps
RUN chmod a+rwx /opt && chmod a+rwx /opt/tomcat/webapps

# Download BIMserver into /webapps for autodeploy

RUN wget https://github.com/opensourceBIM/BIMserver/releases/download/1.4.0-FINAL-2015-11-04/bimserver-1.4.0-FINAL-2015-11-04.war \
	-O /opt/tomcat/webapps/BIMserver.war

# Set environment paths for Tomcat

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
ENV CATALINA_HOME=/opt/tomcat
ENV JAVA_OPTS="-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"
ENV CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

# Add roles and increase file size for webapps to 500Mb

ADD ./web.xml /opt/tomcat/webapps/manager/WEB-INF/web.xml
ADD ./run.sh /opt/run.sh

##################### INSTALLATION END #####################

USER tomcat
EXPOSE 8080
ENTRYPOINT ["bash", "/opt/run.sh"]
