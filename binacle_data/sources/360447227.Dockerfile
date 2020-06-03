### Zookeeper.
FROM ubuntu:14.04
MAINTAINER Dmitry Platon <platon.dimka@gmail.com>

### Environment.
ENV ZK_TICK_TIME=2000
ENV ZK_INIT_LIMIT=5
ENV ZK_SYNC_LIMIT=2
ENV ZK_CLIENT_PORT=2181

### Install zookeeper.
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
RUN DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]') &&\
    CODENAME=$(lsb_release -cs) &&\
    echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/mesosphere.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install zookeeperd

### Copy start script.
RUN mkdir -p /opt
COPY start_zk.sh /opt
RUN chmod a+x /opt/start_zk.sh

CMD /opt/start_zk.sh
