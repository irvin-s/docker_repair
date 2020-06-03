FROM centos:6.8

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


#  JAVA INSTALL  #

RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm"
RUN rpm -ivh jdk-7u79-linux-x64.rpm
ENV JAVA_HOME /usr/java/default


#  MAVEN INSTALL  #

RUN wget http://mirrors.ircam.fr/pub/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.zip
RUN unzip apache-maven-3.5.0-bin.zip
RUN mv apache-maven-3.5.0/ /opt/maven
ENV MAVEN_HOME /opt/maven
ENV PATH $MAVEN_HOME/bin:$PATH
RUN export PATH MAVEN_HOME
RUN export CLASSPATH=.


#    HUE BUILD   #

WORKDIR /var/lib/hue
COPY {{source}} /var/lib/hue
WORKDIR /var/lib/hue
RUN make -Wno-error -k apps || true
WORKDIR /var/lib/
RUN rm -f /var/lib/hue/data

RUN tar -chzf hue-build.tar.gz hue
RUN mv hue-build.tar.gz /
