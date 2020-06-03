FROM quintenk/jdk7-oracle
MAINTAINER Chris Fregly "chris@fregly.com"

# install tomcat:7
RUN apt-get -y install tomcat7
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/default/tomcat7
