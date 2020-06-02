FROM demoregistry.dataman-inc.com/library/centos7-base:latest
MAINTAINER jyliu jyliu@dataman-inc.com

# install epel
RUN  yum install -y epel-release
# install jdk
RUN yum install -y java-1.8.0-openjdk && yum clean all
# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0
