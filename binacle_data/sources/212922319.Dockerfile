FROM jeanblanchard/java:jdk-8

MAINTAINER pjpires@gmail.com

RUN apk add --update \
        linux-headers build-base autoconf automake libtool apr-util apr-util-dev git cmake ninja go

ARG NETTY_TCNATIVE_TAG=netty-tcnative-parent-2.0.7.Final
ENV NETTY_TCNATIVE_TAG $NETTY_TCNATIVE_TAG
ENV MAVEN_VERSION 3.3.9
ENV MAVEN_HOME /usr/share/maven

RUN cd /usr/share ; \
        wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -O - | tar xzf - ;\
        mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven ;\
        ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

VOLUME /output

ADD compile.sh /compile.sh
CMD /compile.sh
