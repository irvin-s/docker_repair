FROM ubuntu:latest
MAINTAINER pwittchen
USER root

# installing required ubuntu software
RUN apt-get update
RUN apt-get -y install software-properties-common

# installing Java 9 from Oracle
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java9-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java9-installer

# cleaning
RUN apt-get -y remove software-properties-common
RUN apt-get clean autoclean -y
RUN apt-get autoremove -y
