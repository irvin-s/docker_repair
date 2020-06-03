### Mesos master.
FROM ubuntu:14.04
MAINTAINER Dmitry Platon <platon.dimka@gmail.com>

### Environment.
ENV MESOS_BUILD_VERSION=1.0.0-2.0.89.ubuntu1404

### Install mesos.
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
RUN DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]') &&\
    CODENAME=$(lsb_release -cs) &&\
    echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/mesosphere.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install mesos=${MESOS_BUILD_VERSION}
RUN apt-mark hold mesos

### Environment.
ENV MESOS_WORK_DIR=/var/lib/mesos
ENV MESOS_LOG_DIR=/var/log/mesos

### Copy start script.
RUN mkdir -p /opt
COPY start_mesos_master.sh /opt
RUN chmod a+x /opt/start_mesos_master.sh

CMD /opt/start_mesos_master.sh
