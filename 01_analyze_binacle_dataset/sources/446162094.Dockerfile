# Ubuntu 12.04 (precise) + Java
#
FROM nlothian/java
MAINTAINER Nick Lothian nick.lothian@gmail.com

RUN echo "deb http://ppa.launchpad.net/natecarlson/maven3/ubuntu precise main" | tee -a /etc/apt/sources.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

RUN apt-get update

RUN apt-get -y --force-yes install maven3


