FROM centos:centos6.6

MAINTAINER Atos

RUN yum install -y tar && \
	yum clean all

ADD jdk-7u67-linux-x64.tar.gz /opt
RUN rm -rv /opt/jdk1.7.0_67/man/man1/ /opt/jdk1.7.0_67/src.zip
RUN mkdir -p /usr/java/ && \
	mv /opt/jdk1.7.0_67 /usr/java/default

RUN chown -R root: /usr/java/default && \
	alternatives --install /usr/bin/java java /usr/java/default/bin/java 1 && \
	alternatives --install /usr/bin/javac javac /usr/java/default/bin/javac 1 && \
	alternatives --install /usr/bin/jar jar /usr/java/default/bin/jar 1

ENV JAVA_VER 7
ENV JAVA_HOME /usr/java/default
