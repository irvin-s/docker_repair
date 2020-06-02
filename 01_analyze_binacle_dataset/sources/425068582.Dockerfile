FROM centos:centos7

MAINTAINER remi@rvkb.com

ENV JAVA_VERSION 7u75
ENV BUILD_VERSION b13

# Upgrading system

RUN yum -y upgrade

RUN yum -y install wget tar unzip

# Downloading Java

RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/jdk-$JAVA_VERSION-linux-x64.rpm" -O /tmp/jdk-linux-x64.rpm
RUN yum -y install /tmp/jdk-linux-x64.rpm
RUN alternatives --install /usr/bin/java jar /usr/java/latest/bin/java 200000
RUN alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000
ENV JAVA_HOME /usr/java/latest

RUN wget http://www.interior-dsgn.com/apache/tomcat/tomcat-8/v8.0.20/bin/apache-tomcat-8.0.20.tar.gz
RUN tar zxf apache-tomcat-8.0.20.tar.gz
RUN rm apache-tomcat-8.0.20.tar.gz

RUN rm -rf /apache-tomcat-8.0.20/webapps/*
ADD taste-cloud.war /apache-tomcat-8.0.20/webapps/ROOT.war

EXPOSE 8080
CMD /apache-tomcat-8.0.20/bin/catalina.sh run

