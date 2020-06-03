FROM centos:7

MAINTAINER Lucas Bakalian <https://github.com/lucasbak>

WORKDIR /tmp/

#  BUILDING TOOLS INSTALL  #

RUN yum clean all
RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y ant
RUN yum install -y asciidoc
RUN yum install -y cyrus-sasl-devel
RUN yum install -y cyrus-sasl-gssapi
RUN yum install -y gcc
RUN yum install -y gcc-c++
RUN yum install -y krb5-devel
RUN yum install -y libtidy
RUN yum install -y libxml2-devel
RUN yum install -y libxslt-devel
RUN yum install -y make
RUN yum install -y mysql
RUN yum install -y mysql-devel
RUN yum install -y openldap-devel
RUN yum install -y python-devel
RUN yum install -y sqlite-devel
RUN yum install -y openssl-devel
RUN yum install -y gmp-devel
RUN yum install -y wget unzip tar words git
RUN yum install -y libffi-devel


#  JAVA INSTALL  #
WORKDIR /tmp
RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.rpm"
RUN rpm -ivh jdk-8u152-linux-x64.rpm
ENV JAVA_HOME /usr/java/default

ENV JAVA_HOME /usr/java/default
RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip"
RUN unzip jce_policy-8.zip
RUN cp UnlimitedJCEPolicyJDK8/US_export_policy.jar /usr/java/default/jre/lib/security/US_export_policy.jar
RUN cp UnlimitedJCEPolicyJDK8/local_policy.jar /usr/java/default/jre/lib/security/local_policy.jar


#  MAVEN INSTALL  #

RUN wget http://mirrors.ircam.fr/pub/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.zip
RUN unzip apache-maven-3.5.2-bin.zip
RUN mv apache-maven-3.5.2/ /opt/maven
ENV MAVEN_HOME /opt/maven
ENV PATH $MAVEN_HOME/bin:$PATH
RUN export PATH MAVEN_HOME
RUN export CLASSPATH=.


#    HUE BUILD   #

WORKDIR /tmp
RUN curl -L -o hue.tar.gz "https://github.com/cloudera/hue/archive/release-4.1.0.tar.gz"
RUN mkdir /var/lib/hue
RUN tar -C /var/lib/hue/ -xzf /tmp/hue.tar.gz --strip-components 1
# COPY {{source}} /var/lib/hue
WORKDIR /var/lib/hue
# RUN git branch --track branch-4.1.0 origin/branch-4.1.0
# RUN git checkout branch-4.1.0
RUN make -Wno-error -k apps || true
WORKDIR /var/lib/
RUN ls -l /var/lib/hue/build/env/bin/
RUN rm -f /var/lib/hue/data

RUN tar -chzf hue-build.tar.gz hue
RUN mv hue-build.tar.gz /
