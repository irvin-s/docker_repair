FROM ubuntu:14.04

MAINTAINER kiwenlau <kiwenlau@gmail.com>

# 设置时区
RUN sudo echo "Asia/Tokyo" > /etc/timezone && \
    sudo dpkg-reconfigure -f noninteractive tzdata

WORKDIR /root

RUN apt-get update && apt-get install -y curl

# Install Java 8 from Oracle's PPA
RUN  sudo apt-get install -y software-properties-common && \
     sudo add-apt-repository ppa:webupd8team/java && \
     echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
     sudo apt-get update -y && \
     sudo apt-get install -y oracle-java8-installer oracle-java8-set-default

# install mesos 0.26.0
RUN sudo apt-get update && sudo apt-get install -y software-properties-common libsvn1 libcurl3 && \
    sudo add-apt-repository ppa:openjdk-r/ppa -y && \
    sudo apt-get update && \
    curl -O http://downloads.mesosphere.io/master/ubuntu/14.04/mesos_0.26.0-0.2.145.ubuntu1404_amd64.deb && \
    sudo dpkg -i mesos_0.26.0-0.2.145.ubuntu1404_amd64.deb && \
    rm mesos_0.26.0-0.2.145.ubuntu1404_amd64.deb 

# install docker 1.11.1
RUN curl -fLsS https://get.docker.com/ | sed 's/docker-engine/docker-engine=1.11.1-0~trusty/' | sh

COPY start-mesos-master.sh /usr/local/bin/start-mesos-master.sh
COPY start-mesos-slave.sh /usr/local/bin/start-mesos-slave.sh

RUN chmod +x /usr/local/bin/start-mesos-master.sh /usr/local/bin/start-mesos-slave.sh

