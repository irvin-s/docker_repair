# Dockerfile for CDH3 base
# 

FROM ubuntu

MAINTAINER wildschu@teco.edu

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list; \
apt-get update; \
apt-get upgrade -y;

# Fake a fuse install
RUN apt-get install libfuse2; \
cd /tmp ; apt-get download fuse; \
cd /tmp ; dpkg-deb -x fuse_* .; \
cd /tmp ; dpkg-deb -e fuse_*; \
cd /tmp ; rm fuse_*.deb; \
cd /tmp ; echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst; \
cd /tmp ; dpkg-deb -b . /fuse.deb; \
cd /tmp ; dpkg -i /fuse.deb;

RUN apt-get install -q -y openjdk-7-jdk; \
apt-get install -q -y ant; \
apt-get install -q -y vim; \
apt-get install -q -y unzip; \
apt-get install -q -y curl; \
apt-get install -q -y wget; \
apt-get install -q -y sudo; \
apt-get install -q -y lbzip2; 

RUN wget http://archive.cloudera.com/one-click-install/maverick/cdh3-repository_1.0_all.deb; \
dpkg -i cdh3-repository_1.0_all.deb; \
apt-get update -qq; \
apt-get install -q -y hadoop-0.20-conf-pseudo; \
echo 'export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/' >> /etc/default/hadoop-0.20; \
chmod a+w /usr/bin/hadoop-0.20; \
echo '#!/bin/sh\n. /etc/default/hadoop-0.20\nexec /usr/lib/hadoop-0.20/bin/hadoop "$@"' > /usr/bin/hadoop-0.20; \
chmod a+x /usr/bin/hadoop-0.20;

ADD conf.docker /etc/hadoop-0.20/conf.docker
RUN update-alternatives --install /etc/hadoop-0.20/conf hadoop-0.20-conf /etc/hadoop-0.20/conf.docker 50; \
update-alternatives --set hadoop-0.20-conf /etc/hadoop-0.20/conf.docker