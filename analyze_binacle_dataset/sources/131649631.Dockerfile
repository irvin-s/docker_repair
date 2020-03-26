# Dockerfile for oracle java 7
# docker pull barnybug/oracle-java7
FROM ubuntu:12.04
MAINTAINER Barnaby Gray <barnaby@pickle.me.uk>

RUN apt-get install -y python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y

RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# just for testing
CMD java -version