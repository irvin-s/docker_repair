FROM ubuntu:12.04
MAINTAINER tony.bussieres@ticksmith.com
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install wget -y
RUN wget http://archive.cloudera.com/cdh5/one-click-install/precise/amd64/cdh5-repository_1.0_all.deb
RUN dpkg -i /cdh5-repository_1.0_all.deb
RUN apt-get install -y  python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer vim
